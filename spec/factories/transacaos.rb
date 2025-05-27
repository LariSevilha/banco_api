FactoryBot.define do
  factory :transacao do
    conta_origem { nil }
    conta_destino { nil }
    valor { "9.99" }
    descricao { "MyString" }
    data_hora { "2025-05-26 15:38:56" }
    agendada { false }
    executar_em { "2025-05-26 15:38:56" }
  end
end
