class Product < ApplicationRecord
  belongs_to :category
  belongs_to :seller, class_name: "User", foreign_key: "user_id"
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :restrict_with_error
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
