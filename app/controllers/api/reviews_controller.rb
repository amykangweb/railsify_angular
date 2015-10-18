class Api::ReviewsController < Api::ApiController

  def create
    product = Product.find(review_params[:product_id])
    review = Review.create(product: product, stars: review_params[:stars], body: review_params[:body], author: review_params[:author])
    if review.save
      render json: review, status: :created
    else
      render json: {"error" => "Could not create review."}, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:author, :stars, :body, :product_id)
  end
end
