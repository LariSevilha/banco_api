class ApplicationController < ActionController::API
    rescue_from JWT::DecodeError, with: :unauthorized_access
    rescue_from JWT::ExpiredSignature, with: :unauthorized_access
    rescue_from JWT::VerificationError, with: :unauthorized_access
  
    def unauthorized_access
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
end  