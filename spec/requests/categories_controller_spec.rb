require "rails_helper"


RSpec.describe "Api::V1::CategoriesController", type: :request do
    # TEST CASE TO SHOW ALL CATEGORIES
    it "shows all the categories" do
   category=Category.create!(name: "electronics")
    post "/api/v1/login", params: {
        user: {
            email: "seller@gmail.com",
            password: "seller@2318"
        }
       }
        get "/api/v1/categories",
        headers: {
           "Autherization" =>"token"
        }
      expect(response).to have_http_status(:ok)
    end
end
