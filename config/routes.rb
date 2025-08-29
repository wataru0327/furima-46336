Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  # トップページを items#index に設定
  root "items#index"

  # items リソースを定義
  resources :items

  # Rails のヘルスチェック用
  get "up" => "rails/health#show", as: :rails_health_check

  # 例: 他の root を設定したい場合のテンプレート
  # root "posts#index"
end