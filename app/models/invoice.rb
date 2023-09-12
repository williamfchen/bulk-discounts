class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :items, through: :invoice_items
  validates :customer_id, presence: true
  validates :status, presence: true
  has_many :invoice_items

  enum :status,["in progress", "completed", "cancelled"]

end
