class Api::ProductsController < Api::ApiController
  skip_before_filter :api_session_token_authenticate!, only: [:index]
  skip_before_filter :verify_authenticity_token
  protect_from_forgery with: :null_session

  def index
    render json: Product.all
  end
  # goal = Goal.find(params[:id])
  #render json: goal.as_json(include:[:entries])
  def create
    product = Product.new(product_params)
    @user = user.find_by(params[:username])
    if params[:api_key] == @user.api_secret
      product.save
      render json: product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  private

  def _provided_valid_api_key?
    params[:api_key] && UserAuthenticationService.authenticate_with_api_key!(@user, params[:api_key], current_api_session_token)
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :specifications)
  end
end
