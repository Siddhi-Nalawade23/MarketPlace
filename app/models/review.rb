class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :comment, presence: true
  validates :rating, inclusion: { in: 1..5 }, allow_nil: true
  validates :user_id, uniqueness: { scope: :product_id, message: "has already reviewed this product" }
end
