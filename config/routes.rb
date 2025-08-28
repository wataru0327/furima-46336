Rails.application.routes.draw do
  root "items#index" 
  resources :items
end
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
