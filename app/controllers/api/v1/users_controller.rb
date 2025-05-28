module Api
    module V1
      class UsersController < ApplicationController
        def index
          users = User.all
          render json: users
        end
        
        def create
          result = UserServices::Create.call(params)
          if result.success?
            render json: { message: 'Conta criada com sucesso' }, status: :created
          else
            render json: { errors: result.errors }, status: :unprocessable_entity
          end
        end
      end
   end
end 
