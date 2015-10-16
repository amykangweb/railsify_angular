class Api::ProductsController < Api::ApiController

  def index
    render json: Product.all
  end

  def create
    @user = User.find_by_username(params[:username])
    product = Product.new(product_params)
    if create_product?
      product.save
      render json: product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  private

  def create_product?
    @user && @user.admin? && @user.api_secret == params[:api_secret]
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :specifications, :image)
  end
end
