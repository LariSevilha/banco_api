module Authenticable
   def authenticate_request!
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue
      render json: { error: 'Unauthorized' }, status: :unauthorized
   end
end