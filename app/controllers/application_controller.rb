class ApplicationController < ActionController::API
  before_action :authorized, only: [:auto_login]
  @secret = Rails.application.credentials.secret_key_base


  def encode_token(payload)
    # { Authorization: 'Bearer <token>' }
    JWT.encode(payload, @secret)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, @secret, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = UserManager.get_by_id(user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
