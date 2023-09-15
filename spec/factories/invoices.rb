FactoryBot.define do
  factory :invoice do
    customer
    status { [0, 1, 2].sample }
    created_at { Faker::Date.between(from: '2014-09-23', to: '2023-09-25') }
  end
end
