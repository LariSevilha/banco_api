module Authenticable
   extend ActiveSupport::Concern
   included do
     before_action :authenticate_user!
   end
   def authenticate_user!
     header = request.headers['Authorization']
     token = header.split(' ').last if header
     begin
       decoded = JsonWebToken.decode(token)
       @current_user = User.find(decoded[:user_id])
     rescue ActiveRecord::RecordNotFound, JWT::DecodeError
       render json: { error: 'Não autorizado' }, status: :unauthorized
     end
   end
   def current_user
     @current_user
   end
 end