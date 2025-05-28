module Api
  module V1
    class TransferenciasController < ApplicationController
      include Authenticable
      before_action :authenticate_user!

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

      def pix
        result = TransferServices::PixTransfer.call(@current_user, params)
        if result.success?
          render json: { message: 'Transferência PIX realizada com sucesso' }, status: :ok
        else
          render json: { error: result.error }, status: :unprocessable_entity
        end
      end
      def deposit
        result = TransferServices::Deposit.call(@current_user, params)
        if result.success?
          render json: { message: 'Depósito realizado com sucesso' }, status: :ok
        else
          render json: { error: result.error }, status: :unprocessable_entity
        end
      end
    end
  end
end