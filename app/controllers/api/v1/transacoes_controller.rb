module Api
    module V1
      class TransacoesController < ApplicationController
        include Filters::Authenticable
        before_action :authenticate_request!
  
        def index
          result = TransactionServices::Extract.call(@current_user, params)
          render json: result.transactions, status: :ok
        end
      end
    end
end