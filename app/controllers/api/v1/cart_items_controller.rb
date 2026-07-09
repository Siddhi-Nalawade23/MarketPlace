class Api::V1::CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    cart_items = current_user.cart_items.includes(:product)
    render json: cart_items, include: :product
  end

  def create
    cart_item = current_user.cart_items.find_or_initialize_by(product_id: params[:product_id])
    cart_item.quantity = (cart_item.quantity || 0) + (params[:quantity] || 1).to_i

    if cart_item.save
      render json: cart_item, status: :created
    else
      render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    cart_item = current_user.cart_items.find(params[:id])
    if cart_item.update(quantity: params[:quantity])
      render json: cart_item
    else
      render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    cart_item = current_user.cart_items.find(params[:id])
    cart_item.destroy
    render json: { message: "Item removed from cart" }
  end
end
