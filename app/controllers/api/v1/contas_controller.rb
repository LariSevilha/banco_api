module Api
  module V1
    class ContasController < ApplicationController
      include Authenticable 
      def saldo
        render json: { saldo: current_user.conta_bancaria.saldo }
      end
    end
  end
end