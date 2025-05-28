module TransactionServices
    class Extract
      def self.call(user, params)
        conta = user.conta_bancarias
        transacoes = Transacao.where("conta_origem_id = ? OR conta_destino_id = ?", conta.id, conta.id)
        transacoes = transacoes.where("data_hora >= ?", params[:data_inicio]) if params[:data_inicio]
        transacoes = transacoes.where("data_hora <= ?", params[:data_fim]) if params[:data_fim]
        transacoes = transacoes.where("valor >= ?", params[:valor_minimo]) if params[:valor_minimo]
  
        if params[:tipo] == 'enviadas'
          transacoes = transacoes.where(conta_origem: conta)
        elsif params[:tipo] == 'recebidas'
          transacoes = transacoes.where(conta_destino: conta)
        end
  
        OpenStruct.new(success?: true, transactions: transacoes.order(data_hora: :desc))
      end
    end
end