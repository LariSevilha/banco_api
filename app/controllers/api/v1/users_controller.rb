module Api
    module V1
      class UsersController < ApplicationController
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