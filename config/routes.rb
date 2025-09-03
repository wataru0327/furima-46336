Rails.application.routes.draw do
  devise_for :users
  
  root "items#index"

  resources :items do
    resources :orders, only: [:index, :create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end