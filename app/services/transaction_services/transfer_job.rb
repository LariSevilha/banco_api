class TransferJob < ApplicationJob
  queue_as :default

  def perform(user_id, params)
    ActiveRecord::Base.transaction do
      user = User.find(user_id)
      origem = user.conta_bancaria
      destino = ContaBancaria.find_by(id: params[:conta_destino_id])
      raise 'Conta destino não encontrada' unless destino
      raise 'Não é possível transferir para a mesma conta' if origem == destino
      raise 'Saldo insuficiente' if origem.saldo < params[:valor].to_f
      origem.update!(saldo: origem.saldo - params[:valor].to_f)
      destino.update!(saldo: destino.saldo + params[:valor].to_f)
      Transacao.create!(
        conta_origem: origem,
        conta_destino: destino,
        valor: params[:valor].to_f,
        descricao: params[:descricao],
        data_hora: Time.current,
        agendada: true
      )
    end
  rescue StandardError => e
    Rails.logger.error "TransferJob failed: #{e.message}"
  end
end