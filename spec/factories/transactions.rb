FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Finance.credit_card }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { [0, 1].sample }
  end
end
