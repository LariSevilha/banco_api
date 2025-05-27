module UserServices
    class Create
      def self.call(params)
        user = User.new(params.permit(:nome, :email, :cpf, :password, :password_confirmation))
        if user.save
          ContaBancaria.create!(user: user, numero_conta: SecureRandom.hex(5), agencia: '0001', saldo: 0)
          OpenStruct.new(success?: true)
        else
          OpenStruct.new(success?: false, errors: user.errors.full_messages)
        end
      end
   end
end