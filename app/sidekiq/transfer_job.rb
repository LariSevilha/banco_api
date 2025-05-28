class TransferJob < ApplicationJob
  queue_as :default
  def perform(user_id, params)
    ActiveRecord::Base.transaction do
      user = User.find(user_id)
      origem = user.conta_bancaria
      destino = ContaBancaria.find_by(id: params[:conta_destino_id])
      raise 'Conta destino não encontrada' unless destino
      raise 'Saldo insuficiente' if origem.saldo < params[:valor]
      origem.update!(saldo: origem.saldo - params[:valor])
      destino.update!(saldo: destino.saldo + params[:valor])
      Transacao.create!(
        conta_origem: origem,
        conta_destino: destino,
        valor: params[:valor],
        descricao: params[:descricao],
        data_hora: Time.current,
        agendada: true
      )
    end
  rescue StandardError => e
    Rails.logger.error "TransferJob failed: #{e.message}"
  end
end