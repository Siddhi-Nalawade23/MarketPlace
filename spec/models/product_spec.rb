require "rails_helper"

RSpec.describe Product, type: :model do
        it "is invalid without a price" do
        product=Product.new(price: nil)
        expect(product).to be_invalid
    end

    it "is invalid when the eprice is 0" do
       product=Product.new(price: 0)
       expect(product).to be_invalid
    end

    it "is invalid when price is less than 0" do
        product=Product.new(price: -100)
        expect(product).to be_invalid
    end
     it "is invalid without a stock" do
        product=Product.new(stock: nil)
        expect(product).to be_invalid
    end
    it "is invalid when stock is less than 0" do
        product=Product.new(stock: -2)
        expect(product).to be_invalid
    end

     it "is valid when stock is 0" do
         category=Category.create!(
            name: "electronics"
        )
        user = User.create!(
          name: "Radhika",
          email: "radhika@example.com",
          password: "password@123",
          role: "seller"
        )
        product=Product.create(
            category: category,
            description: "its is very nice product , has good brand name",
            image_url: "https://m.media-amazon.com/images/I/61wlBz6vo6L._SX522_.jpg",
            name: "Orange Headphones",
            price: 800.0,
            stock: 0,
            seller: user,)
        expect(product).to be_valid
    end


    it "is invalid without a name" do
        product=Product.new(name: nil)
        expect(product).to be_invalid
    end

    it "belongs to category" do
    association=Product.reflect_on_association(:category)
    expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to seller" do
    association=Product.reflect_on_association(:seller)
    expect(association.macro).to eq(:belongs_to)
    end

    it "has many cart items" do
        association=Product.reflect_on_association(:cart_items)
        expect(association.macro).to eq(:has_many)
    end

    it "has mnay order items" do
    association=Product.reflect_on_association(:order_items)
    expect(association.macro).to eq(:has_many)
    end

    it "has many reviews " do
        association=Product.reflect_on_association(:reviews)
        expect(association.macro).to eq(:has_many)
    end
end
