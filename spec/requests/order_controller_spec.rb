require "rails_helper"

RSpec.describe "Api::V1::OrdersController", type: :request do
    it "is creating the order " do
        user=User.create!(
           email: "siddhi@gmail.com",
           password: "Siddhi@2318",
           role: "buyer",
           name: "siddhi"
        )
        seller=User.create!(
           email: "seller12@gmail.com",
           password: "seller@2318",
           role: "seller",
           name: "seller"

        )
        category=Category.create!(name: "electronics")
        product=Product.create!(
            name: "Laptop",
            description: "Gaming laptop",
            price: 50000,
            stock: 10,
            seller: seller,
            category: category
        )
        cartitem=CartItem.create!(
         product: product,
         quantity: 2,
         user: user
        )
       post "/api/v1/login", params: {
        user: {
          email: "siddhi@gmail.com",
          password: "Siddhi@2318"
        }
       }

  token = response.headers["Authorization"]
  post "/api/v1/orders",
    params: {
      shipping_name: "Siddhi",
      shipping_phone: "9876543210",
      shipping_address: "Pune",
      shipping_city: "Pune",
      shipping_state: "Maharashtra",
      shipping_pincode: "411001"
    },
    headers: {
      "Authorization" => token
    }
  puts response.body
  expect(response).to have_http_status(:created)
    end

 # TEST CASE : to see all orders
 it "is creating the order " do
        user=User.create!(
           email: "siddhi@gmail.com",
           password: "Siddhi@2318",
           role: "buyer",
           name: "siddhi"
        )
        seller=User.create!(
           email: "seller12@gmail.com",
           password: "seller@2318",
           role: "seller",
           name: "seller"

        )
        category=Category.create!(name: "electronics")
        product=Product.create!(
            name: "Laptop",
            description: "Gaming laptop",
            price: 50000,
            stock: 10,
            seller: seller,
            category: category
        )
        cartitem=CartItem.create!(
         product: product,
         quantity: 2,
         user: user
        )
       post "/api/v1/login", params: {
        user: {
          email: "siddhi@gmail.com",
          password: "Siddhi@2318"
        }
       }

  token = response.headers["Authorization"]
  get "/api/v1/orders",

    headers: {
      "Authorization" => token
    }
  puts response.body
  expect(response).to have_http_status(:ok)
    end





 # TEST CASE : to see all orders
 it "is unauthorize without token too see al orders" do
        user=User.create!(
           email: "siddhi@gmail.com",
           password: "Siddhi@2318",
           role: "buyer",
           name: "siddhi"
        )
        seller=User.create!(
           email: "seller12@gmail.com",
           password: "seller@2318",
           role: "seller",
           name: "seller"

        )
        category=Category.create!(name: "electronics")
        product=Product.create!(
            name: "Laptop",
            description: "Gaming laptop",
            price: 50000,
            stock: 10,
            seller: seller,
            category: category
        )
        cartitem=CartItem.create!(
         product: product,
         quantity: 2,
         user: user
        )
      get "/api/v1/orders"
      expect(response).to have_http_status(:unauthorized)
    end

   # Creating order without cart item
   it "does not create an order when the cart is empty" do
        user=User.create!(
           email: "siddhi@gmail.com",
           password: "Siddhi@2318",
           role: "buyer",
           name: "siddhi"
        )
        seller=User.create!(
           email: "seller12@gmail.com",
           password: "seller@2318",
           role: "seller",
           name: "seller"

        )
        category=Category.create!(name: "electronics")
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
          email: "siddhi@gmail.com",
          password: "Siddhi@2318"
        }
       }

  token = response.headers["Authorization"]
  post "/api/v1/orders",
    params: {
      shipping_name: "Siddhi",
      shipping_phone: "9876543210",
      shipping_address: "Pune",
      shipping_city: "Pune",
      shipping_state: "Maharashtra",
      shipping_pincode: "411001"
    },
    headers: {
      "Authorization" => token
    }
  puts response.body
  expect(response).to have_http_status(:unprocessable_content)
    end
end
