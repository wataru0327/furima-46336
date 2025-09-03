Payjp.configure do |config|
  config.public_key = Rails.application.credentials.dig(:payjp, :public_key)
  config.secret_key = Rails.application.credentials.dig(:payjp, :secret_key)
end
