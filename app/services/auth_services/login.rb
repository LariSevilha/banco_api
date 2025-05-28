module AuthServices
  class Login
    def self.call(params)
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: user.id)
        OpenStruct.new(success?: true, token: token)
      else
        OpenStruct.new(success?: false, error: 'Invalid email or password')
      end
    end
  end
end