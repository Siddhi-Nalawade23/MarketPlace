class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :update, :destroy ]
  before_action :require_seller!, only: [ :create, :update, :destroy ]
  before_action :set_product, only: [ :show, :update, :destroy ]

  def index
    render json: Product.all
  end

  def show
    render json: @product
  end

  def create
    product = current_user.products.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    render json: { message: "Product deleted" }
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :category_id, :image_url)
  end

  def require_seller!
    unless current_user.role == "seller"
      render json: { error: "Only sellers can manage products" }, status: :forbidden
    end
  end
end
