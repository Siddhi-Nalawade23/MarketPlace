require "rails_helper"

RSpec.describe "Api::V1::ProductsController", type: :request do
  # TEST CASE: For All Products
  it "returns all products" do
   seller = User.create!(
    name: "Test Seller",
    email: "seller@test.com",
    password: "password",
    role: "seller"
  )

  category = Category.create!(
    name: "Electronics"
  )

  Product.create!(
    name: "Laptop",
    description: "Gaming laptop",
    price: 50000,
    stock: 10,
    seller: seller,
    category: category
  )
    post "/api/v1/login", params: {
    user: {
      email: "seller@test.com",
      password: "password"
    }
  }

  token = response.headers["Authorization"]

  get "/api/v1/products", headers: {
    "Authorization" => token
  }
  get "/api/v1/products"

  expect(response).to have_http_status(:ok)
 end

 # TEST CASE: for creating Product
 it " it create products" do
   seller = User.create!(
    name: "Test Seller",
    email: "seller@test.com",
    password: "password",
    role: "seller"
  )
  category = Category.create!(
    name: "Electronics"
  )
  Product.create!(
    name: "Laptop",
    description: "Gaming laptop",
    price: 50000,
    stock: 10,
    seller: seller,
    category: category
  )
  post "/api/v1/login", params: {
    user: {
      email: "seller@test.com",
      password: "password"
    }
  }

  token = response.headers["Authorization"]
  post "/api/v1/products",
  params: {
    product: {
      name: "Laptop",
      description: "Gaming laptop",
      price: 50000,
      stock: 10,
      category_id: category.id
    }
  },
  headers: {
    "Authorization" => token
  }
  expect(response).to have_http_status(:created)
  end

  # TEST CASE: for deleting products

  it "it delete products" do
   seller = User.create!(
    name: "Test Seller",
    email: "seller@test.com",
    password: "password",
    role: "seller"
  )

  category = Category.create!(
    name: "Electronics"
  )

  product=Product.create!(
    name: "Laptop",
    description: "Gaming laptop",
    price: 50000,
    stock: 10,
    seller: seller,
    category: category
  )
  post "/api/v1/login", params: {
    user: {
      email: "seller@test.com",
      password: "password"
    }
  }
  token = response.headers["Authorization"]
  delete "/api/v1/products/#{product.id}",
    headers: {
    "Authorization" => token
  }
  expect(response).to have_http_status(:ok)
  end

#   TEST CASE : FORR SHOW PRODUCTS ALONG WOTH ID
it "is return specific products by id " do
   seller = User.create!(
    name: "Test Seller",
    email: "seller@test.com",
    password: "password",
    role: "seller"
  )
  category = Category.create!(
    name: "Electronics"
  )
  product=Product.create!(
    name: "Laptop",
    description: "Gaming laptop",
    price: 50000,
    stock: 10,
    seller: seller,
    category: category
  )
    post "/api/v1/login", params: {
    user: {
      email: "seller@test.com",
      password: "password"
    }
  }
  token = response.headers["Authorization"]
  get "/api/v1/products", headers: {
    "Authorization" => token
  }
  get "/api/v1/products/#{product.id}"
  expect(response).to have_http_status(:ok)
 end

  # TEST CASE: For All Products without token
  it "returns all products" do
   seller = User.create!(
    name: "Test Seller",
    email: "seller@test.com",
    password: "password",
    role: "seller"
  )

  category = Category.create!(
    name: "Electronics"
  )

  Product.create!(
    name: "Laptop",
    description: "Gaming laptop",
    price: 50000,
    stock: 10,
    seller: seller,
    category: category
  )
   get "/api/v1/products"

  expect(response).to have_http_status(:ok)
 end
end
