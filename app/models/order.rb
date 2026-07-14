class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :shipping_name, :shipping_phone, :shipping_address,
            :shipping_city, :shipping_state, :shipping_pincode, presence: true
  validates :shipping_phone, format: { with: /\A[6-9]\d{9}\z/, message: "must be a valid 10-digit Indian mobile number" }
  validates :shipping_pincode, format: { with: /\A\d{6}\z/, message: "must be a valid 6-digit pincode" }

  def sellers
    User.where(id: order_items.joins(:product).select("products.user_id"))
  end
end
