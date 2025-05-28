require 'rails_helper'

RSpec.describe "Api::V1::Transferencias", type: :request do
  describe "POST /api/v1/transferencias/agendada" do
    context "quando o usuário não está autenticado" do
      it "retorna status 401 Unauthorized" do
        post "/api/v1/transferencias/agendada", params: {}, as: :json
        expect(response).to have_http_status(:unauthorized)
        expect(json_response['error']).to eq('Não autorizado')
      end
    end

    context "quando o token JWT é inválido" do
      it "retorna status 401 Unauthorized" do 
        headers = { "Authorization" => "Bearer invalid.jwt.token" }
        post "/api/v1/transferencias/agendada", params: {}, headers: headers, as: :json
        expect(response).to have_http_status(:unauthorized)
        expect(json_response['error']).to eq('Não autorizado')
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end