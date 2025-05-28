module Api
  module V1
    class AuthenticationController < ApplicationController
      def login
        result = AuthServices::Login.call(params)
        if result.success?
          render json: { token: result.token }, status: :ok
        else
          render json: { error: result.error }, status: :unauthorized
        end
      end
    end
  end
end