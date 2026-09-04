require "rails_helper"


RSpec.describe OrderItem, type: :model do
    it "belongs to order" do
    association=OrderItem.reflect_on_association(:order)
    expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to Product" do
    association=OrderItem.reflect_on_association(:product)
    expect(association.macro).to eq(:belongs_to)
    end

    it "is invalid when quntity is not present" do
        orderitem=OrderItem.new(quantity: nil)
        expect(orderitem).to be_invalid
    end
    it "is invalid when Quantity is less than 0" do
        orderitem=OrderItem.new(quantity: -5)
         expect(orderitem).to be_invalid
    end

    it "is invalid when price is less than 0" do
        orderitem=OrderItem.new(price: -5)
         expect(orderitem).to be_invalid
    end
end
