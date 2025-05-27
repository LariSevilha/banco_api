module AuthServices
    class Login
      def self.call(email, password)
        user = User.find_by(email: email)
        if user&.authenticate(password)
          token = JsonWebToken.encode(user_id: user.id)
          OpenStruct.new(success?: true, token: token)
        else
          OpenStruct.new(success?: false, error: 'Email ou senha inválidos')
        end
      end
    end
end