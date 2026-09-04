require "rails_helper"


RSpec.describe "Api::V1::ReviewsController", type: :request do
    it "create review for product" do
        user=User.create!(
            name: "Test Seller",
            email: "seller@test.com",
            password: "password",
            role: "buyer"
        )
        category=Category.create(name: "electronics")

        seller=User.create!(
            name: "Test Seller",
            email: "teller@test.com",
            password: "password",
            role: "seller"
        )

        product=Product.create!(
        name: "Laptop",
        description: "Gaming laptop",
        price: 50000,
        stock: 10,
        seller: seller,
        category: category
        )
        post "/api/v1/login",
        params: {
        user: {
        email: "seller@test.com",
        password: "password"
        }
    }
        token = response.headers["Authorization"]

    post "/api/v1/products/#{product.id}/reviews",
    params: {
        review: {
            comment: "nice",
            # product: product,
            rating: 3
          # user:user
        }
    },
    headers: {
        "Authorization"=>token
    }

    expect(response).to have_http_status(:created)
    end

    # see all reviews
    it "create review for product" do
        user=User.create!(
            name: "Test Seller",
            email: "seller@test.com",
            password: "password",
            role: "buyer"
        )
        category=Category.create(name: "electronics")

        seller=User.create!(
            name: "Test Seller",
            email: "teller@test.com",
            password: "password",
            role: "seller"
        )

        product=Product.create!(
        name: "Laptop",
        description: "Gaming laptop",
        price: 50000,
        stock: 10,
        seller: seller,
        category: category
        )
        post "/api/v1/login",
        params: {
        user: {
        email: "seller@test.com",
        password: "password"
        }
    }
        token = response.headers["Authorization"]

    get "/api/v1/products/#{product.id}/reviews",

    headers: {
        "Authorization"=>token
    }
      expect(response).to have_http_status(:ok)
end
    # update review
    it "updates review" do
  user = User.create!(
    name: "Test Buyer",
    email: "buyer@test.com",
    password: "password",
    role: "buyer"
  )

  category = Category.create!(
    name: "electronics"
  )

  seller = User.create!(
    name: "Test Seller",
    email: "seller@test.com",
    password: "password",
    role: "seller"
  )

  product = Product.create!(
    name: "Laptop",
    description: "Gaming laptop",
    price: 50000,
    stock: 10,
    seller: seller,
    category: category
  )

  # Existing review that we want to update
  review = Review.create!(
    comment: "Old comment",
    rating: 2,
    product: product,
    user: user
  )

  post "/api/v1/login",
    params: {
      user: {
        email: "buyer@test.com",
        password: "password"
      }
    }

  token = response.headers["Authorization"]

  patch "/api/v1/products/#{product.id}/reviews/#{review.id}",
    params: {
      review: {
        comment: "Updated comment",
        rating: 5
      }
    },
    headers: {
      "Authorization" => token
    }

  expect(response).to have_http_status(:ok)
end
#  create without authentication
it "create review for product" do
        user=User.create!(
            name: "Test Seller",
            email: "seller@test.com",
            password: "password",
            role: "buyer"
        )
        category=Category.create(name: "electronics")

        seller=User.create!(
            name: "Test Seller",
            email: "teller@test.com",
            password: "password",
            role: "seller"
        )

        product=Product.create!(
        name: "Laptop",
        description: "Gaming laptop",
        price: 50000,
        stock: 10,
        seller: seller,
        category: category
        )

    post "/api/v1/products/#{product.id}/reviews",
    params: {
        review: {
            comment: "nice",
            # product: product,
            rating: 3
          # user:user
        }
    }
    expect(response).to have_http_status(:unauthorized)
  end
end
