class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  include SessionsHelper

  def authenticate_user
    unless request_token
      render json: { errors: 'Invalid request' }, status: :unauthorized and return
    end

    JsonWebToken.decode(request_token)
  end

  def request_token
    return unless auth_header = request.headers['Authorization']

    scheme, token = auth_header.split(' ')
    scheme == 'Bearer' ? token : nil
  end
end
