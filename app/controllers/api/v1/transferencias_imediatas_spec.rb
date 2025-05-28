require 'rails_helper'

RSpec.describe 'Transferência Imediata', type: :request do
  describe 'POST /api/v1/transferencias/imediata' do
    let!(:origem) { ContaBancaria.create!(numero: '12345-6', saldo: 500.0) }
    let!(:destino) { ContaBancaria.create!(numero: '98765-4', saldo: 100.0) }

    let(:valid_params) do
      {
        transfer: {
          origin_account: origem.numero,
          destination_account: destino.numero,
          amount: 150.0
        }
      }
    end

    it 'realiza a transferência imediata com sucesso' do
      post '/api/v1/transferencias/imediata', params: valid_params.to_json, headers: { 'Content-Type': 'application/json' }

      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body['message']).to eq('Transferência imediata realizada com sucesso.')
    end

    it 'falha com saldo insuficiente' do
      valid_params[:transfer][:amount] = 9999.0
      post '/api/v1/transferencias/imediata', params: valid_params.to_json, headers: { 'Content-Type': 'application/json' }

      expect(response).to have_http_status(:unprocessable_entity)
      body = JSON.parse(response.body)
      expect(body['error']).to eq('Saldo insuficiente')
    end
  end
end
