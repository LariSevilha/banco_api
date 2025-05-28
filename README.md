Banco API
Descrição do Projeto
O Banco API é uma API REST desenvolvida em Ruby on Rails que simula operações bancárias básicas, incluindo autenticação com JWT, gerenciamento de usuários, consulta de saldo, transferências entre contas (PIX), agendamento de transferências futuras e visualização de extrato com filtros. O projeto utiliza Docker para containerização, PostgreSQL como banco de dados e Sidekiq com Redis para processamento assíncrono de tarefas, como transferências agendadas.
Funcionalidades

Autenticação com JWT: Geração de tokens JWT para login e proteção de rotas.
Gerenciamento de Usuários: Criação de usuários com contas bancárias associadas.
Operações Bancárias:
Consulta de saldo.
Transferências imediatas (PIX) com validação de saldo.
Agendamento de transferências futuras usando Sidekiq.
Visualização de extrato com filtros (intervalo de datas, valor mínimo, tipo de transação).


Segurança:
Senhas armazenadas com hash seguro (bcrypt).
Operações atômicas para evitar problemas de concorrência.
Proteção contra transferências duplicadas.
Apenas o titular da conta acessa seus dados.



Tecnologias Utilizadas

Ruby on Rails (~7.0)
PostgreSQL (banco de dados)
Redis e Sidekiq (tarefas assíncronas)
JWT (autenticação)
Docker (containerização)
cpf_cnpj (validação de CPF)

Pré-requisitos

Docker e Docker Compose instalados.
Acesso a um terminal de comandos.
Conexão com a internet para baixar imagens Docker e dependências.

Instalação e Configuração

Clone o Repositório:
git clone <repository-url>
cd banco_api


Construa e Inicie os Serviços:
docker-compose build
docker-compose up -d


Isso inicia os serviços web (aplicação Rails), db (PostgreSQL) e redis (para Sidekiq).


Instale as Dependências:
docker-compose run web bundle install


Configure o Banco de Dados:
docker-compose exec web bin/rails db:create
docker-compose exec web bin/rails db:migrate


Inicie o Sidekiq (para transferências agendadas):
docker-compose exec web bundle exec sidekiq



Execução da Aplicação

A API está disponível em `[invalid url, do not cite]
Para parar os serviços:docker-compose down


Para verificar o status dos serviços:docker-compose ps



Autenticação
A autenticação é feita via JWT (JSON Web Tokens). Para acessar rotas protegidas (/api/v1/conta/saldo, /api/v1/transferencias, /api/v1/transferencias/agendada, /api/v1/extrato), é necessário incluir um token JWT no cabeçalho Authorization como Bearer <token>.
Obter um Token JWT
Faça uma requisição POST para /api/v1/auth/login:
curl -X POST [invalid url, do not cite] \
  -H "Content-Type: application/json" \
  -d '{"email":"maria@email.com","password":"123456"}'


Resposta:{"token":"seu token"}
 
Pontos de Extremidade da API
A API segue a convenção de prefixo /api/v1/. Abaixo estão os endpoints disponíveis, seus métodos, parâmetros e respostas esperadas.
 

Endpoint
Método
Parâmetros
Autenticação
Resposta Esperada
 

/api/v1/users
POST
nome, email, cpf, password, password_confirmation
Não
{"message":"Conta criada com sucesso"} (201 Created)


/api/v1/auth/login
POST
email, password
Não
{"token":"eyJhbG..."} (200 OK)


/api/v1/conta/saldo
GET
Nenhum
Sim
{"saldo":0.0} (200 OK)


/api/v1/transferencias
POST
valor, descricao, conta_destino_id
Sim
{"message":"Transferência realizada com sucesso"} (200 OK)


/api/v1/transferencias/agendada
POST
valor, descricao, conta_destino_id, executar_em (ISO 8601)
Sim
{"message":"Transferência agendada com sucesso"} (200 OK)


/api/v1/extrato
GET
start_date, end_date, min_val (opcional)
Sim
[{"id":1,"conta_origem_id":1,"conta_destino_id":2,...}] (200 OK)


Exemplos de Requisições
Criar Usuários
curl -X POST [invalid url, do not cite] \
  -H "Content-Type: application/json" \
  -d '{"nome":"Maria","email":"maria@email.com","cpf":"12345678901","password":"123456","password_confirmation":"123456"}'

curl -X POST [invalid url, do not cite] \
  -H "Content-Type: application/json" \
  -d '{"nome":"Joao","email":"joao@email.com","cpf":"98765432109","password":"123456","password_confirmation":"123456"}'


Resposta: {"message":"Conta criada com sucesso"} (201 Created)

Login
curl -X POST [invalid url, do not cite] \
  -H "Content-Type: application/json" \
  -d '{"email":"maria@email.com","password":"123456"}'


Resposta: {"token":"eyJhbG..."} (200 OK)

Consultar Saldo
curl -X GET [invalid url, do not cite] \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3NDg1NTEzMzN9.LjlOD0CVA1nua5d0SBd-bVUGD19mN2qAicln_dmtj28"


Resposta: {"saldo":0.0} (200 OK)

Realizar Transferência
Adicione fundos à conta de Maria para testes:
docker-compose exec db psql -U banco_api -d banco_api -c "UPDATE conta_bancarias SET saldo = 1000.0 WHERE user_id = (SELECT id FROM users WHERE email = 'maria@email.com');"

Obtenha o ID da conta de destino (Joao):
docker-compose exec db psql -U banco_api -d banco_api -c "SELECT id, user_id, numero_conta FROM conta_bancarias;"

Assumindo que o ID da conta de Joao é 2:
curl -X POST [invalid url, do not cite] \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer TOKEN" \
  -d '{"valor":100.0,"descricao":"Test transfer","conta_destino_id":2}'


Resposta: {"message":"Transferência realizada com sucesso"} (200 OK)

Agendar Transferência
O comando fornecido pelo usuário aninhava os parâmetros sob "transfer", o que é incorreto. Use parâmetros no nível superior:
curl -X POST [invalid url, do not cite] \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer TOKEN" \
  -d '{"valor":50.0,"descricao":"Transferência agendada","conta_destino_id":2,"executar_em":"2025-05-29T12:00:00Z"}'


Resposta: {"message":"Transferência agendada com sucesso"} (200 OK)
Nota: O parâmetro executar_em deve estar no formato ISO 8601 (e.g., "2025-05-29T12:00:00Z") e ser uma data futura em relação ao momento atual (28 de maio de 2025, 20:49 UTC).

Listar Transações
curl -X GET [invalid url, do not cite] \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer TOKEN"


Resposta: [{"id":1,"conta_origem_id":1,"conta_destino_id":2,"valor":100.0,"descricao":"Test transfer","data_hora":"2025-05-28T14:43:00Z"}] (200 OK)

Realizar Transferência PIX 
Para realizar uma transferência PIX, utilize o endpoint `/api/v1/transferencias/pix`. Certifique-se de que o usuário autenticado tenha saldo suficiente.

Exemplo de requisição: 

curl -X POST "http://localhost:3000/api/v1/transferencias/pix" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <seu_token>" \
  -d '{"valor":100.0,"descricao":"Transferência PIX","conta_destino_id":2}'

Resposta esperada:

{
  "message": "Transferência PIX realizada com sucesso"
}

Se houver erro (como saldo insuficiente ou conta de destino inválida), a resposta será:

{
  "error": "Mensagem de erro"
}

Realizar Depósito
Para realizar um depósito na conta do usuário autenticado, utilize o endpoint /api/v1/transferencias/deposito.

Exemplo de requisição:
curl -X POST "http://localhost:3000/api/v1/transferencias/deposito" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <seu_token>" \
  -d '{"valor":200.0}'

Resposta esperada:
{
  "message": "Depósito realizado com sucesso"
}
Se houver erro (como valor inválido), a resposta será:
{
  "error": "Mensagem de erro"
}

Transferência PIX: Certifique-se de que o conta_destino_id seja válido e que o saldo do usuário seja suficiente para realizar a transferência.
Depósito: Apenas valores positivos são aceitos.

Testes

Utilize ferramentas como Postman ou curl para testar os endpoints.
Certifique-se de usar um token JWT válido para rotas protegidas.
Para verificar o banco de dados:docker-compose exec db psql -U banco_api -d banco_api -c "SELECT * FROM conta_bancarias;"


(Opcional) Se testes RSpec estiverem implementados, execute:docker-compose exec web bundle exec rspec



Implantação
O projeto é projetado para rodar com Docker, facilitando a implantação em ambientes que suportem Docker Compose. Para produção:

Configure RAILS_ENV=production no docker-compose.yml.
Proteja credenciais sensíveis (e.g., POSTGRES_PASSWORD, SECRET_KEY_BASE) usando variáveis de ambiente ou ferramentas como Docker Secrets.
Considere usar um servidor web como NGINX para servir a aplicação.

Decisões Técnicas

JWT para Autenticação: Garante segurança nas rotas protegidas, com tokens expirando após 24 horas.
Sidekiq para Tarefas Assíncronas: Permite agendamento de transferências futuras, processadas de forma confiável.
Docker: Assegura consistência entre ambientes de desenvolvimento e produção.
PostgreSQL: Banco de dados robusto com suporte a chaves estrangeiras para integridade de dados.
Transações Atômicas: Usadas em transferências para evitar problemas de concorrência.
Validação de CPF: Implementada com a gem cpf_cnpj para garantir CPFs válidos.

O que Faria Diferente com Mais Tempo

Adicionar documentação da API com Swagger ou Postman.
Implementar paginação no endpoint /api/v1/extrato usando a gem kaminari.
Criar testes RSpec abrangentes para controllers e serviços.
Adicionar logs de auditoria estruturados em JSON.
Implementar limitação de taxa (rate limiting) para prevenir abusos.

Contribuições
Contribuições são bem-vindas! Siga os passos abaixo:

Faça um fork do repositório.
Crie uma branch para sua feature ou correção (git checkout -b feature/nova-funcionalidade).
Envie um pull request com suas alterações. 