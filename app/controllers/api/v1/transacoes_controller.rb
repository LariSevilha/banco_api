module Api
  module V1
    class TransacoesController < ApplicationController
      include Authenticable
      before_action :authenticate_user!
      def index
        result = TransactionServices::Extract.call(@current_user, params)
        render json: result.transactions, status: :ok
      end
    end
  end
end