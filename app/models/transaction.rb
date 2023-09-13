class Transaction < ApplicationRecord
  belongs_to :invoice
  # has_many :customers, through: :invoices

  validates :invoice_id, presence: true
  validates :credit_card_number, presence: true
  validates :credit_card_expiration_date, presence: true
  validates :result, presence: true

  enum :result,["failed", "success"]
end
