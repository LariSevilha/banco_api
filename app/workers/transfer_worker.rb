class TransferWorker
    include Sidekiq::Worker
  
    def perform(transacao_id)
      transacao = Transacao.find(transacao_id)
      conta_origem = transacao.conta_origem
      conta_destino = transacao.conta_destino
  
      ActiveRecord::Base.transaction do
        raise 'Saldo insuficiente' if conta_origem.saldo < transacao.valor
  
        conta_origem.update!(saldo: conta_origem.saldo - transacao.valor)
        conta_destino.update!(saldo: conta_destino.saldo + transacao.valor)
  
        transacao.update!(data_hora: Time.current, agendada: false)
      end
    rescue => e
      Rails.logger.error("Erro ao processar transferência agendada ##{transacao_id}: #{e.message}")
    end
  end
  