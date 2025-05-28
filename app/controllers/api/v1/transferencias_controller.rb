module Api
  module V1
    class TransferenciasController < ApplicationController
      include Filters::Authenticable    
      before_action :authenticate_request!
      def create
        result = TransferServices::PixTransfer.call(@current_user, params)
        if result.success?
          render json: { message: 'Transferência realizada com sucesso' }, status: :ok
        else
          render json: { error: result.error }, status: :unprocessable_entity
        end
      end
      def schedule
        result = TransferServices::ScheduleTransfer.call(@current_user, params)
        if result.success?
          render json: { message: 'Transferência agendada com sucesso' }, status: :ok
        else
          render json: { error: result.error }, status: :unprocessable_entity
        end
      end
    end
  end
end

# eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE3NDg1NDU0Mjh9.4vFAiUdGVyPnUlzboQfg-zxyGNMiSYDQk6dHOYRFCo4