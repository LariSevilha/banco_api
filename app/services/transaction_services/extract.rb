module TransactionServices
    class Extract
      def self.call(current_user, params)
        account = current_user.conta_bancaria
        transactions = Transacao.sent_by_account(account.id).or(Transacao.received_by_account(account.id))
        transactions = transactions.between_dates(params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
        transactions = transactions.min_value(params[:min_val]) if params[:min_val].present?
        OpenStruct.new(transactions: transactions.order(data_hora: :desc))
      end
    end
  end
 
 