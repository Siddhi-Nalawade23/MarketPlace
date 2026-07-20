class Api::V1::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :update ]
  before_action :set_product
  before_action :set_review, only: [ :update ]

  # GET /api/v1/products/:product_id/reviews
  def index
    reviews = @product.reviews.includes(:user).order(created_at: :desc)
    render json: reviews, include: { user: { only: [ :id, :name ] } }
  end

  # POST /api/v1/products/:product_id/reviews
  def create
    review = @product.reviews.new(review_params.merge(user: current_user))
    if review.save
      render json: review, status: :created
    else
      render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/products/:product_id/reviews/:id
  def update
    if @review.user != current_user
      return render json: { error: "You can only edit your own review" }, status: :forbidden
    end

    if @review.update(review_params)
      render json: @review
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_review
    @review = @product.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
