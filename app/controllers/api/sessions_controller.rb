class Api::SessionsController < Api::ApiController
  skip_before_filter :api_session_token_authenticate!, only: [:create]
  skip_before_filter :verify_authenticity_token
  protect_from_forgery with: :null_session

  def create
    token = current_api_session_token

    if params[:username] && params[:password]
      @user = User.find_by_username(params[:username])
      token.user = @user
      if @user.password == params[:password] || _provided_valid_api_key?
        render json: token
      else
        render json: { message: "Username / Password combo not valid."}
      end
    end
  end

  private

  def _provided_valid_password?
    params[:password] && User.authenticate_with_password!(@user, params[:password])
  end

  def _provided_valid_api_key?
    params[:api_key] && UserAuthenticationService.authenticate_with_api_key!(@user, params[:api_key], current_api_session_token.token)
  end
end
