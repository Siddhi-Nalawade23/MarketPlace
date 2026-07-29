class Api::V1::ReviewRepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review
  before_action :require_seller!

  # POST /api/v1/reviews/:review_id/reply
  def create
    if @review.product.user_id != current_user.id
      return render json: { error: "You can only reply to reviews on your own products" }, status: :forbidden
    end

    reply = @review.build_reply(reply_params.merge(seller: current_user))
    if reply.save
      render json: reply, status: :created
    else
      render json: { errors: reply.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/reviews/:review_id/reply
  def update
    reply = @review.reply
    if reply.nil? || reply.seller_id != current_user.id
      return render json: { error: "Reply not found or not yours" }, status: :forbidden
    end

    if reply.update(reply_params)
      render json: reply
    else
      render json: { errors: reply.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end

  def require_seller!
    unless current_user.role == "seller"
      render json: { error: "Only sellers can reply to reviews" }, status: :forbidden
    end
  end

  def reply_params
    params.require(:review_reply).permit(:comment)
  end
end
