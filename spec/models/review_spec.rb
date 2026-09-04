require "rails_helper"

RSpec.describe Review, type: :model do
     it "belongs to product" do
        association=Review.reflect_on_association(:product)
        expect(association.macro).to eq(:belongs_to)
    end

     it "belongs to user" do
        association=Review.reflect_on_association(:user)
        expect(association.macro).to eq(:belongs_to)
    end

     it "has one reply" do
        association=Review.reflect_on_association(:reply)
        expect(association.macro).to eq(:has_one)
    end
     it "is invalid without comment" do
        review=Review.new(comment: nil)
        expect(review).to be_invalid
    end

    it "is valid when rating is 1 to 5" do
        category=Category.create!(
            name: "electronics"
        )
        user = User.create!(
          name: "Radhika",
          email: "radhika@example.com",
          password: "password@123",
          role: "seller"
        )
        product=Product.create!(
            category: category,
            description: "its is very nice product , has good brand name",
            image_url: "https://m.media-amazon.com/images/I/61wlBz6vo6L._SX522_.jpg",
            name: "Orange Headphones",
            price: 800.0,
            stock: 8,
            seller: user,
        )
        review=Review.new(rating: 5,
        product: product,
        user: user,
        comment: 'Nice')
        expect(review).to be_valid
    end

     # it"is Invalid when rating is greater than 5" do
     #     category=Category.create!(
     #         name:"electronics"
     #     )
     #     user = User.create!(
     #       name: "Radhika",
     #       email: "radhika@example.com",
     #       password: "password@123",
     #       role: "seller"
     #     )
     #     product=Product.create(
     #         category: category,
     #         description: "its is very nice product , has good brand name",
     #         image_url: "https://m.media-amazon.com/images/I/61wlBz6vo6L._SX522_.jpg",
     #         name: "Orange Headphones",
     #         price: 800.0,
     #         stock: 8,
     #         seller: user,
     #     )
     #     review=Review.new(rating:6,
     #     product:product,
     #     user:user,
     #     comment:'Nice')
     #     expect(review).to be_invalid
     # end

     it "is Invalid when rating is less than 1" do
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
            stock: 8,
            seller: user,
        )
        review=Review.new(rating: 0,
        product: product,
        user: user,
        comment: 'Nice')
        expect(review).to be_invalid
    end
     it "is Invalid when rating is less than 1" do
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
            stock: 8,
            seller: user,
        )
        review=Review.new(rating: -2,
        product: product,
        user: user,
        comment: 'Nice')
        expect(review).to be_invalid
    end

    it "is invalid when rating is greater than 5" do
        review=Review.new(rating: 6,
        product_id: 1,
        user_id: 1,
        comment: 'Nice')
        expect(review).to be_invalid
    end

    it "is invalid when the same user reviews the same product twice" do
    category = Category.create!(name: "electronics")

        user = User.create!(
        name: "Radhika",
        email: "radhika@example.com",
        password: "password@123",
        role: "seller"
    )

    product = Product.create!(
        category: category,
        description: "It is a very nice product",
        image_url: "https://example.com/image.jpg",
        name: "Orange Headphones",
        price: 800.0,
        stock: 8,
        seller: user
    )

    Review.create!(
        rating: 5,
        product: product,
        user: user,
        comment: "Nice"
    )

    second_review = Review.new(
        rating: 4,
        product: product,
        user: user,
        comment: "Good product"
    )

    expect(second_review).to be_invalid
    end
end
