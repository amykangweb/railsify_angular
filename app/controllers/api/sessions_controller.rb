class Api::SessionsController < Api::ApiController
  skip_before_filter :api_session_token_authenticate!, only: [:create]

  def create
    if params[:username]
      @user = User.find_by_username(params[:username])
      token.user = @user if _provided_valid_password? || _provided_valid_api_key?
    end
    Rails.logger.info "Logging in token: #{token}"
    # respond_with token
  end

  private

  def _provided_valid_password?
    params[:password] && UserAuthenticationService.authenticate_with_password!(@user, params[:password])
  end

  def _provided_valid_api_key?
    params[:api_key] == 'foo key'
  end

end
