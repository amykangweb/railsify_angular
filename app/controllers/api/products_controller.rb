class Api::ProductsController < Api::ApiController
  before_action :find_user, only: [:create, :update, :destroy]
  before_action :set_product, only: [:update, :destroy]

  def index
    render json: Product.all
  end

  def create
    product = Product.new(product_params)
    if create_product?
      product.save
      render json: product, status: :created
    else
      render json: {"error" => "Could not create gem, check validations"}, status: :unprocessable_entity
    end
  end

  def update
    if create_product?
      @product.update(product_params)
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if create_product?
      @product.destroy
      render json: {"notice" => "Gem successfully destroyed."}
    else
      render json: {"error" => "Could not update gem, check validations"}, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by_username(params[:username])
  end

  def create_product?
    @user && @user.admin? && @user.api_secret == params[:api_secret]
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :specifications, :image)
  end
end
