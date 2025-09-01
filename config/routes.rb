Rails.application.routes.draw do
  devise_for :users
  
 
  root "items#index"


  resources :items


  get "up" => "rails/health#show", as: :rails_health_check
end