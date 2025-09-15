FactoryBot.define do
  factory :shipping_address do
    association :order, strategy: :create  

    postal_code   { "123-4567" }
    prefecture_id { 2 }
    city          { "横浜市" }
    address       { "青山1-1-1" }
    building      { "柳ビル103" }
    phone_number  { "09012345678" }
  end
end



