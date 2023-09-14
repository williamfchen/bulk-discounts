FactoryBot.define do
  factory :item do
    merchant
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.between(from: 100, to: 10000) }
  end
end
