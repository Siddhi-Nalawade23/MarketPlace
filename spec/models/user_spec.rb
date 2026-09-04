require "rails_helper"

RSpec.describe User, type: :model do
        it "is invalid without a name" do
        user=User.new(name: nil)
        expect(user).to be_invalid
    end

    it "is valid with a name" do
     user = User.new(
        name: "Siddhi",
        email: "siddhi@example.com",
        password: "password123")
     expect(user).to be_valid
    end

    it "has many orders" do
    association=User.reflect_on_association(:orders)
    expect(association.macro).to eq(:has_many)
    end

    it "has many cart_items" do
        association=User.reflect_on_association(:cart_items)
        expect(association.macro).to eq(:has_many)
    end

    it "has many products" do
     association=User.reflect_on_association(:products)
     expect(association.macro).to eq(:has_many)
    end

    it "has many reviews" do
     association=User.reflect_on_association(:reviews)
     expect(association.macro).to eq(:has_many)
    end
end
