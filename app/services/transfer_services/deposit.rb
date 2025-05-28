module TransferServices
  class Deposit
    def self.call(current_user, params)
      valor = params[:valor].to_f

      if valor <= 0
        return OpenStruct.new(success?: false, error: 'O valor do depósito deve ser maior que zero.')
      end

      conta = current_user.conta_bancaria
      if conta.nil?
        return OpenStruct.new(success?: false, error: 'Conta bancária não encontrada.')
      end

      ActiveRecord::Base.transaction do
        conta.saldo += valor
        conta.save!
      end

      OpenStruct.new(success?: true)
    rescue => e
      OpenStruct.new(success?: false, error: e.message)
    end
  end
end