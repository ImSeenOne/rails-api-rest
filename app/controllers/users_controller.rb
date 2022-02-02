class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  def create
    logger.debug "Entered to users#create"
    @user = UserManager.create(user_params[:id], user_params[:username], user_params[:password], user_params[:password_confirmation], user_params[:name], user_params[:lastname], user_params[:bio])
    if @user.valid?
      token = encode_token({user_id: @user_id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}, status: 401
    end
  end

  def login
    @user = UserManager.get_by_username(user_params[:username])

    if @user && @user.authenticate(user_params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: { error: "Invalid username or password" }, status: 401
    end
  end

  def auto_login
    render json: @user
  end

  private
    def user_params
      params.permit(:id, :username, :password, :password_confirmation, :name, :lastname, :bio)
    end

end
