require "rails_helper"


RSpec.describe "Api::V1::SessionsController", type: :request do
    # TEST CASE:For LogIn User
    it "Login with valid credentials" do
    user=User.create!(
        email: "seller@gmail.com",
        password: "seller@2318",
        name: "siddhi",
        role: "buyer"
    )
     post "/api/v1/login", params: {
        user: {
            email: "seller@gmail.com",
            password: "seller@2318"
        }
       }
       expect(response).to have_http_status(:ok)
    end

     # TEST CASE: Logout the user
     it "Logout the user" do
    user=User.create!(
        email: "seller@gmail.com",
        password: "seller@2318",
        name: "siddhi",
        role: "buyer"
    )
    post "/api/v1/login", params: {
        user: {
            email: "seller@gmail.com",
            password: "seller@2318"
        }
       }
       token = response.headers["Authorization"]
       delete "/api/v1/logout",
       headers: {
       "Authorization" => token
      }
       expect(response).to have_http_status(:ok)
    end

     # TEST CASE: Logout without token
     it "Logout the user" do
    user=User.create!(
        email: "seller@gmail.com",
        password: "seller@2318",
        name: "siddhi",
        role: "buyer"
    )
    post "/api/v1/login", params: {
        user: {
            email: "seller@gmail.com",
            password: "seller@2318"
        }
       }
       token = response.headers["Authorization"]
       delete "/api/v1/logout"

       expect(response).to have_http_status(:ok)
    end
end
