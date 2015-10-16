class Api::SessionsController < Api::ApiController

  def create
    @user = User.find_by_username(params[:username])
    @user.api_secret = generate_token
    @user.save
    if @user.is_password?(params[:password])
      render json: { "token": @user.api_secret, "user": @user }
    else
      render json: { "error": "Username\Password combination invalid." }
    end
  end

  private

  def generate_token
    @user.admin? ? MicroToken.generate(128) : nil
  end
end
