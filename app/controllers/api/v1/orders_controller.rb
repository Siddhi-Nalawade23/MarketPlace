class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    orders = current_user.orders.includes(order_items: :product)
    render json: orders, include: { order_items: { include: :product } }
  end

  def show
    order = current_user.orders.find(params[:id])
    render json: order, include: { order_items: { include: :product } }
  end

  def create
    cart_items = current_user.cart_items.includes(:product)

    if cart_items.empty?
      return render json: { error: "Your cart is empty" }, status: :unprocessable_entity
    end

    order = nil

    ActiveRecord::Base.transaction do
      total = cart_items.sum { |item| item.product.price * item.quantity }
      order = current_user.orders.create!(status: "pending", total: total)

      cart_items.each do |item|
        order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          price: item.product.price
        )
      end

      cart_items.destroy_all
    end

    render json: order, include: { order_items: { include: :product } }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
