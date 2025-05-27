module TransferServices
    class PixTransfer
        def self.call(user, params)
        conta_origem = user.conta_bancaria
        conta_destino = ContaBancaria.find(params[:conta_destino_id])
        valor = params[:valor].to_d

        ActiveRecord::Base.transaction do
            return OpenStruct.new(success?: false, error: 'Saldo insuficiente') if conta_origem.saldo < valor

            conta_origem.update!(saldo: conta_origem.saldo - valor)
            conta_destino.update!(saldo: conta_destino.saldo + valor)

            Transacao.create!(
            conta_origem: conta_origem,
            conta_destino: conta_destino,
            valor: valor,
            descricao: params[:descricao],
            data_hora: Time.current,
            agendada: false
            )

            OpenStruct.new(success?: true)
        rescue => e
            OpenStruct.new(success?: false, error: e.message)
        end
        end
    end
end