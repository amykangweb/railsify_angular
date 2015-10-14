class Api::ProductsController < ApplicationController
  def index
    render json: Product.all
  end
  # goal = Goal.find(params[:id])
  #render json: goal.as_json(include:[:entries])
  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :specifications, :image)
  end
end
