require "rails_helper"

RSpec.describe "Api::V1::RegistrationsController", type: :request do
    # TEST CASE FOR LOGIN
    it "login the user" do
       user=User.create!(name: "Test seller",
       email: "seller@gmail.com",
       password: "seller@2318",
       role: "seller"
       )
       post "/api/v1/login", params: {
        user: {
            email: "seller@gmail.com",
            password: "seller@2318"
        }
       }
       expect(response).to have_http_status(:ok)
    end
end
