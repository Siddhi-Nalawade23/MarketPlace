class Api::V1::SellerOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_seller!

  def index
    order_items = OrderItem.includes(:product, :order).all
    render json: order_items, include: [ :product, :order ]
  end

  private

  def require_seller!
    unless current_user.role == "seller"
      render json: { error: "Only sellers can view this" }, status: :forbidden
    end
  end
end
