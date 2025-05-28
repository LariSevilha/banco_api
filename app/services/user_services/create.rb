module UserServices
  class Create
    def self.call(params)
      user = User.new(params.permit(:nome, :email, :cpf, :password, :password_confirmation))
      if user.save
        OpenStruct.new(success?: true)
      else
        OpenStruct.new(success?: false, errors: user.errors.full_messages)
      end
    end
  end
end