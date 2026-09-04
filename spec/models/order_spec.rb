require "rails_helper"

RSpec.describe Order, type: :model do
    it "is invalid without status" do
        order=Order.new(status: nil)
        expect(order).to be_invalid
    end

    it "is sinvalid without total" do
        order=Order.new(total: nil)
        expect(order).to be_invalid
    end
    it "is invalid when total is less than 0" do
        order=Order.new(total: -2)
        expect(order).to be_invalid
    end
    it "is valid when total is equal to 0" do
         user = User.create!(
          name: "Siddhi",
          email: "siddhi@example.com",
          password: "password@123"
        )
        order=Order.new(total: 0,
            user: user,
            shipping_phone: 7412589632,
            shipping_name: "Omkar Ghadge",
            shipping_address: "Shiroli",
            shipping_city: "Pune",
            shipping_state: "Maharashtra",
            shipping_pincode: "410511"
        )
        expect(order).to be_valid
    end

    it "is invalid without shipping_name,shipping_phone,shipping_address,shipping_city,shipping_state,shipping_pincode in" do
        order=Order.new(
            shipping_name: nil,
            shipping_phone: nil,
            shipping_address: nil,
            shipping_city: nil,
            shipping_state: nil,
            shipping_pincode: nil

        )
        expect(order).to be_invalid
    end

    it "is invalid when phone number digit is less than 10" do
     order=Order.new(shipping_phone: 123456325)
     expect(order).to be_invalid
    end

     it "is valid when phone number is 10 digit" do
          user = User.create!(
          name: "Omkar",
          email: "omkar@example.com",
          password: "password@123"
        )
        order=Order.new(shipping_phone: 7412589632,
            user: user,
            shipping_name: "Omkar Ghadge",
            shipping_address: "Shiroli",
            shipping_city: "Pune",
            shipping_state: "Maharashtra",
            shipping_pincode: "410511"

        )
        expect(order).to be_valid
     end

     it "is valid when length of pincode is equal to 6" do
         user = User.create!(
          name: "shravni",
          email: "shravni@gmail.com",
          password: "shravni@123"
        )
        order=Order.new(
            shipping_pincode: "410515",
            shipping_phone: 7412589632,
            user: user,
            shipping_name: "Omkar Ghadge",
            shipping_address: "Shiroli",
            shipping_city: "Pune",
            shipping_state: "Maharashtra",
        )
        expect(order).to be_valid
     end

       it "is invalid when length of pincode is greater to 6 digit" do
         user = User.create!(
          name: "shravni",
          email: "shravni@gmail.com",
          password: "shravni@123"
        )
        order=Order.new(
            shipping_pincode: "4105155",
            shipping_phone: 7412589632,
            user: user,
            shipping_name: "Omkar Ghadge",
            shipping_address: "Shiroli",
            shipping_city: "Pune",
            shipping_state: "Maharashtra",
        )
        expect(order).to be_invalid
     end
      it "has many order_items" do
        association=Order.reflect_on_association(:order_items)
        expect(association.macro).to eq(:has_many)
      end
    it "has mnay products through order_items" do
        association=Order.reflect_on_association(:products)
        expect(association.macro).to eq(:has_many)
    end
    it "has belongs to User" do
        association=Order.reflect_on_association(:user)
        expect(association.macro).to eq(:belongs_to)
    end
end
