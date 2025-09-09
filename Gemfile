source "https://rubygems.org"

ruby "3.2.0"

gem "rails", "~> 7.1.0"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false


gem 'devise'


group :production do
  gem "pg", "~> 1.5"
end


group :development, :test do
  gem "mysql2", "~> 0.5"


  gem "debug", platforms: %i[ mri windows ]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  gem "rubocop", "1.71.2", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem 'active_hash'

gem 'payjp'

group :test do
  gem 'database_cleaner-active_record'
end

gem "aws-sdk-s3", require: false