require "rails_helper"

RSpec.describe "Api::V1::CartItemsController", type: :request do
    # add item to cart
    it "show all orders" do
        user=User.create!(
           email: "siddhi@gmail.com",
           password: "Siddhi@2318",
           role: "buyer",
           name: "Siddhinalawade"
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
       post "/api/v1/login",

        params: {
        user: {
        email: "siddhi@gmail.com",
        password: "Siddhi@2318"
        }
    }

    token = response.headers["Authorization"]
    post "/api/v1/cart_items",
    params: {
        product_id: product.id,
        product: product,
        quantity: 2
    },
    headers: {
        "Authorization" => token
    }

    expect(response).to have_http_status(:created)
    end
       # without token adding item to cart
       it "show all orders" do
        user=User.create!(
           email: "siddhi@gmail.com",
           password: "Siddhi@2318",
           role: "buyer",
           name: "Siddhinalawade"
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
        post "/api/v1/cart_items",
        params: {
            product_id: product.id,
            product: product,
            quantity: 2
        }

    expect(response).to have_http_status(:unauthorized)
    end

      # show cart items
      it "show all orders" do
        user=User.create!(
           email: "siddhi@gmail.com",
           password: "Siddhi@2318",
           role: "buyer",
           name: "Siddhinalawade"
        )
        order=user.orders.create!(
              status: "pending",
                total: 50000,
                shipping_name: "Siddhi",
                shipping_phone: "9876543210",
                shipping_address: "Pune",
                shipping_city: "Pune",
                shipping_state: "Maharashtra",
                shipping_pincode: "411001"
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
       post "/api/v1/login",

        params: {
        user: {
        email: "siddhi@gmail.com",
        password: "Siddhi@2318"
        }
    }

    token = response.headers["Authorization"]
    get "/api/v1/cart_items",
    headers: {
        "Authorization" => token
    }
    expect(response).to have_http_status(:ok)
   end

      # Delete cart items  without login
      it "show all orders" do
        user=User.create!(
           email: "siddhi@gmail.com",
           password: "Siddhi@2318",
           role: "buyer",
           name: "Siddhinalawade"
        )
        order=user.orders.create!(
              status: "pending",
                total: 50000,
                shipping_name: "Siddhi",
                shipping_phone: "9876543210",
                shipping_address: "Pune",
                shipping_city: "Pune",
                shipping_state: "Maharashtra",
                shipping_pincode: "411001"
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
        cart_item=CartItem.create!(
        product_id: product.id,
        product: product,
        quantity: 2,
        user: user
        )
       post "/api/v1/login",
        params: {
        user: {
        email: "siddhi@gmail.com",
        password: "Siddhi@2318"
        }
    }

    token = response.headers["Authorization"]
    delete "/api/v1/cart_items/#{cart_item.id}",
    headers: {
        "Authorization" => token
    }
    expect(response).to have_http_status(:ok)
   end
      # Delete cart items with out token
      it "is unprocessable when delete cart items without token " do
        user=User.create!(
           email: "siddhi@gmail.com",
           password: "Siddhi@2318",
           role: "buyer",
           name: "Siddhinalawade"
        )
        order=user.orders.create!(
              status: "pending",
                total: 50000,
                shipping_name: "Siddhi",
                shipping_phone: "9876543210",
                shipping_address: "Pune",
                shipping_city: "Pune",
                shipping_state: "Maharashtra",
                shipping_pincode: "411001"
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
        cart_item=CartItem.create!(
        product_id: product.id,
        product: product,
        quantity: 2,
        user: user
        )

    delete "/api/v1/cart_items/#{cart_item.id}"

    expect(response).to have_http_status(:unauthorized)
   end
end
