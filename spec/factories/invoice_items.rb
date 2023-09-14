FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.between(from: 1, to: 10) }
    unit_price { Faker::Number.between(from: 1, to: 1000) }
    status { [0, 1, 2].sample }
  end
end
