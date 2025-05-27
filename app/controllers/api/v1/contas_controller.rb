module Api
    module V1
        class ContasController < ApplicationController
        include Filters::Authenticable
        before_action :authenticate_request!

        def saldo
            conta = @current_user.conta_bancaria
            render json: { saldo: conta.saldo }, status: :ok
        end
        end
    end
end