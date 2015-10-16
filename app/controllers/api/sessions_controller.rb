class Api::SessionsController < Api::ApiController

  def create
    token = MicroToken.generate(128)
    @user = User.find_by_username(params[:username])
    @user.api_secret = token
    @user.save
    if @user.is_password?(params[:password])
      render json: { "token": token, "username": @user.username, "admin": @user.admin }
    else
      render json: { "error": "Username\Password combination invalid." }
    end
  end
end
