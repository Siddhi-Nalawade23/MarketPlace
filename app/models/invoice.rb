class Invoice < ApplicationRecord
  belongs_to :order
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"

  before_create :generate_invoice_number

  validates :amount, numericality: { greater_than: 0 }

  def line_items
    order.order_items.joins(:product).where(products: { user_id: seller_id })
  end

  private

  def generate_invoice_number
    self.invoice_number = "INV-#{Time.current.strftime('%Y%m')}-#{SecureRandom.hex(4).upcase}"
  end
end
