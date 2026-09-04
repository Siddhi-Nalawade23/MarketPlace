require "rails_helper"


RSpec.describe CartItem, type: :model do
    it "belongs to user" do
        association=CartItem.reflect_on_association(:user)
        expect(association.macro).to eq(:belongs_to)
    end

     it "belongs to product" do
        association=CartItem.reflect_on_association(:product)
        expect(association.macro).to eq(:belongs_to)
    end

     it "is invalid when Quantity is less than 0" do
        orderitem=CartItem.new(quantity: -5)
         expect(orderitem).to be_invalid
    end
    it "is invalid when Quantity is 0" do
        orderitem=CartItem.new(quantity: nil)
         expect(orderitem).to be_invalid
    end
end
