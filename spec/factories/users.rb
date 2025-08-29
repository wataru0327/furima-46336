FactoryBot.define do
  factory :user do
    nickname              { 'タロウ' }
    email                 { Faker::Internet.unique.email }
    password              { 'w12345' }
    password_confirmation { password }
    last_name             { '福島' }
    first_name            { '太郎' }
    last_name_kana        { 'フクシマ' }
    first_name_kana       { 'タロウ' }
    birthday              { '1990-01-01' }
  end
end