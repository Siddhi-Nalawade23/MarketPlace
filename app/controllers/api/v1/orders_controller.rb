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
    order = current_user.orders.create!(
      status: "pending",
      total: total,
      shipping_name: params[:shipping_name],
      shipping_phone: params[:shipping_phone],
      shipping_address: params[:shipping_address],
      shipping_city: params[:shipping_city],
      shipping_state: params[:shipping_state],
      shipping_pincode: params[:shipping_pincode]
    )

    cart_items.each do |item|
      order.order_items.create!(
        product: item.product,
        quantity: item.quantity,
        price: item.product.price
      )
    end

    cart_items.destroy_all
  end
  generate_invoices_for(order)

  render json: order, include: { order_items: { include: :product } }, status: :created
rescue ActiveRecord::RecordInvalid => e
  render json: { error: e.message }, status: :unprocessable_entity
end

private

def generate_invoices_for(order)
  order.sellers.each do |seller|
    items = order.order_items.joins(:product).where(products: { user_id: seller.id })
    amount = items.sum("order_items.price * order_items.quantity")

    invoice = Invoice.create!(order: order, seller: seller, buyer: order.user, amount: amount)
    InvoiceMailer.seller_invoice(invoice).deliver_later
  end
end
end
