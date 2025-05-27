module TransferServices
    class ScheduleTransfer
      def self.call(user, params)
        transferencia = Transacao.create!(
          conta_origem: user.conta_bancaria,
          conta_destino_id: params[:conta_destino_id],
          valor: params[:valor],
          descricao: params[:descricao],
          executar_em: params[:executar_em],
          agendada: true
        )
  
        TransferWorker.perform_at(transferencia.executar_em, transferencia.id)
        OpenStruct.new(success?: true)
      rescue => e
        OpenStruct.new(success?: false, error: e.message)
      end
    end
end