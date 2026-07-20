class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
end
