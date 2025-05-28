module TransferServices
    class PixTransfer
      def self.call(current_user, params)
        ActiveRecord::Base.transaction do
          origem = current_user.conta_bancaria
          destino = ContaBancaria.find_by(id: params[:conta_destino_id])
          return OpenStruct.new(success?: false, error: 'Conta destino não encontrada') unless destino
          return OpenStruct.new(success?: false, error: 'Não é possível transferir para a mesma conta') if origem == destino
          return OpenStruct.new(success?: false, error: 'Saldo insuficiente') if origem.saldo < params[:valor].to_f
          origem.update!(saldo: origem.saldo - params[:valor].to_f)
          destino.update!(saldo: destino.saldo + params[:valor].to_f)
          Transacao.create!(
            conta_origem: origem,
            conta_destino: destino,
            valor: params[:valor].to_f,
            descricao: params[:descricao],
            data_hora: Time.current
          )
          OpenStruct.new(success?: true)
        rescue ActiveRecord::RecordInvalid => e
          OpenStruct.new(success?: false, error: e.message)
        end
      end
    end
  end