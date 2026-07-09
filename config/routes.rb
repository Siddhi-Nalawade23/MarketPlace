Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :products, only: [ :index, :show ]
      resources :categories, only: [ :index ]
      resources :cart_items, only: [ :index, :create, :update, :destroy ]
      resources :orders, only: [ :index, :show, :create ]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
