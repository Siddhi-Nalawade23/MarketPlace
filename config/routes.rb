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

  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
