module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  def authenticate_user!
    puts "Verificando autenticação..."
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = JsonWebToken.decode(token)
    puts "Token decodificado com sucesso"
    @current_user = User.find(decoded[:user_id])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
    puts "Erro de autenticação: #{e.message}"
    render json: { error: 'Não autorizado' }, status: :unauthorized
  end

  def current_user
    @current_user
  end
end