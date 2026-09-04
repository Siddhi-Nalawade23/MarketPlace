require "rails_helper"

RSpec.describe "Api::V1::ReviewRepliesController", type: :request do
  # TEST CASE: Seller creates reply to review
  it "creates reply to review" do
    buyer = User.create!(
      email: "buyer@gmail.com",
      password: "buyer@2318",
      name: "buyer",
      role: "buyer"
    )

    seller = User.create!(
      email: "seller@gmail.com",
      password: "seller@2318",
      name: "seller",
      role: "seller"
    )

    category = Category.create!(
      name: "electronics"
    )

    product = Product.create!(
      name: "Laptop",
      description: "Gaming laptop",
      price: 50000,
      stock: 10,
      seller: seller,
      category: category
    )

    review = Review.create!(
      comment: "Nice product",
      rating: 5,
      product: product,
      user: buyer
    )

    post "/api/v1/login",
      params: {
        user: {
          email: "seller@gmail.com",
          password: "seller@2318"
        }
      }

    token = response.headers["Authorization"]

    post "/api/v1/reviews/#{review.id}/reply",
      params: {
        review_reply: {
          comment: "Thank you for your review"
        }
      },
      headers: {
        "Authorization" => token
      }

    expect(response).to have_http_status(:created)
  end


  # TEST CASE: Buyer cannot create reply
  it "does not allow buyer to reply" do
    buyer = User.create!(
      email: "buyer@gmail.com",
      password: "buyer@2318",
      name: "buyer",
      role: "buyer"
    )

    seller = User.create!(
      email: "seller@gmail.com",
      password: "seller@2318",
      name: "seller",
      role: "seller"
    )

    category = Category.create!(
      name: "electronics"
    )

    product = Product.create!(
      name: "Laptop",
      description: "Gaming laptop",
      price: 50000,
      stock: 10,
      seller: seller,
      category: category
    )

    review = Review.create!(
      comment: "Nice product",
      rating: 5,
      product: product,
      user: buyer
    )

    post "/api/v1/login",
      params: {
        user: {
          email: "buyer@gmail.com",
          password: "buyer@2318"
        }
      }

    token = response.headers["Authorization"]

    post "/api/v1/reviews/#{review.id}/reply",
      params: {
        review_reply: {
          comment: "Thank you"
        }
      },
      headers: {
        "Authorization" => token
      }

    expect(response).to have_http_status(:forbidden)
  end


  # TEST CASE: Seller cannot reply to another seller's product
  it "does not allow seller to reply to another seller's product review" do
    buyer = User.create!(
      email: "buyer@gmail.com",
      password: "buyer@2318",
      name: "buyer",
      role: "buyer"
    )

    seller1 = User.create!(
      email: "seller1@gmail.com",
      password: "seller@2318",
      name: "seller1",
      role: "seller"
    )

    seller2 = User.create!(
      email: "seller2@gmail.com",
      password: "seller@2318",
      name: "seller2",
      role: "seller"
    )

    category = Category.create!(
      name: "electronics"
    )

    product = Product.create!(
      name: "Laptop",
      description: "Gaming laptop",
      price: 50000,
      stock: 10,
      seller: seller1,
      category: category
    )

    review = Review.create!(
      comment: "Nice product",
      rating: 5,
      product: product,
      user: buyer
    )

    post "/api/v1/login",
      params: {
        user: {
          email: "seller2@gmail.com",
          password: "seller@2318"
        }
      }

    token = response.headers["Authorization"]

    post "/api/v1/reviews/#{review.id}/reply",
      params: {
        review_reply: {
          comment: "Thank you"
        }
      },
      headers: {
        "Authorization" => token
      }

    expect(response).to have_http_status(:forbidden)
  end


  # TEST CASE: Create reply without token
  it "does not allow unauthenticated user to create reply" do
    buyer = User.create!(
      email: "buyer@gmail.com",
      password: "buyer@2318",
      name: "buyer",
      role: "buyer"
    )

    seller = User.create!(
      email: "seller@gmail.com",
      password: "seller@2318",
      name: "seller",
      role: "seller"
    )

    category = Category.create!(
      name: "electronics"
    )

    product = Product.create!(
      name: "Laptop",
      description: "Gaming laptop",
      price: 50000,
      stock: 10,
      seller: seller,
      category: category
    )

    review = Review.create!(
      comment: "Nice product",
      rating: 5,
      product: product,
      user: buyer
    )

    post "/api/v1/reviews/#{review.id}/reply",
      params: {
        review_reply: {
          comment: "Thank you"
        }
      }

    expect(response).to have_http_status(:unauthorized)
  end


  # TEST CASE: Seller updates own reply
  it "updates own reply" do
    buyer = User.create!(
      email: "buyer@gmail.com",
      password: "buyer@2318",
      name: "buyer",
      role: "buyer"
    )

    seller = User.create!(
      email: "seller@gmail.com",
      password: "seller@2318",
      name: "seller",
      role: "seller"
    )

    category = Category.create!(
      name: "electronics"
    )

    product = Product.create!(
      name: "Laptop",
      description: "Gaming laptop",
      price: 50000,
      stock: 10,
      seller: seller,
      category: category
    )

    review = Review.create!(
      comment: "Nice product",
      rating: 5,
      product: product,
      user: buyer
    )

    reply = ReviewReply.create!(
      review: review,
      seller: seller,
      comment: "Old reply"
    )

    post "/api/v1/login",
      params: {
        user: {
          email: "seller@gmail.com",
          password: "seller@2318"
        }
      }

    token = response.headers["Authorization"]

    patch "/api/v1/reviews/#{review.id}/reply",
      params: {
        review_reply: {
          comment: "Updated reply"
        }
      },
      headers: {
        "Authorization" => token
      }

    expect(response).to have_http_status(:ok)
  end


  # TEST CASE: Seller cannot update another seller's reply
  it "does not allow seller to update another seller's reply" do
    buyer = User.create!(
      email: "buyer@gmail.com",
      password: "buyer@2318",
      name: "buyer",
      role: "buyer"
    )

    seller1 = User.create!(
      email: "seller1@gmail.com",
      password: "seller@2318",
      name: "seller1",
      role: "seller"
    )

    seller2 = User.create!(
      email: "seller2@gmail.com",
      password: "seller@2318",
      name: "seller2",
      role: "seller"
    )

    category = Category.create!(
      name: "electronics"
    )

    product = Product.create!(
      name: "Laptop",
      description: "Gaming laptop",
      price: 50000,
      stock: 10,
      seller: seller1,
      category: category
    )

    review = Review.create!(
      comment: "Nice product",
      rating: 5,
      product: product,
      user: buyer
    )

    reply = ReviewReply.create!(
      review: review,
      seller: seller1,
      comment: "Seller 1 reply"
    )

    post "/api/v1/login",
      params: {
        user: {
          email: "seller2@gmail.com",
          password: "seller@2318"
        }
      }

    token = response.headers["Authorization"]

    patch "/api/v1/reviews/#{review.id}/reply",
      params: {
        review_reply: {
          comment: "Trying to change"
        }
      },
      headers: {
        "Authorization" => token
      }

    expect(response).to have_http_status(:forbidden)
  end


  # TEST CASE: Update reply when reply does not exist
  it "does not update when reply does not exist" do
    buyer = User.create!(
      email: "buyer@gmail.com",
      password: "buyer@2318",
      name: "buyer",
      role: "buyer"
    )

    seller = User.create!(
      email: "seller@gmail.com",
      password: "seller@2318",
      name: "seller",
      role: "seller"
    )

    category = Category.create!(
      name: "electronics"
    )

    product = Product.create!(
      name: "Laptop",
      description: "Gaming laptop",
      price: 50000,
      stock: 10,
      seller: seller,
      category: category
    )

    review = Review.create!(
      comment: "Nice product",
      rating: 5,
      product: product,
      user: buyer
    )

    post "/api/v1/login",
      params: {
        user: {
          email: "seller@gmail.com",
          password: "seller@2318"
        }
      }

    token = response.headers["Authorization"]

    patch "/api/v1/reviews/#{review.id}/reply",
      params: {
        review_reply: {
          comment: "Updated reply"
        }
      },
      headers: {
        "Authorization" => token
      }

    expect(response).to have_http_status(:forbidden)
  end
end
