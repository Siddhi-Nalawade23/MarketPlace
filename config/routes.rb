Rails.application.routes.draw do
  devise_for :users,
    path: "api/v1",
    path_names: { sign_in: "login", sign_out: "logout", registration: "signup" },
    controllers: {
      sessions: "api/v1/sessions",
      registrations: "api/v1/registrations"
    }

  namespace :api do
    namespace :v1 do
      resources :products
      resources :categories, only: [ :index ]
      resources :cart_items, only: [ :index, :create, :update, :destroy ]
      resources :orders, only: [ :index, :show, :create ]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
