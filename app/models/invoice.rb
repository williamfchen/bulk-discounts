class Invoice < ApplicationRecord
  belongs_to :customer
  has_many items, through: :invoice_items

  enum :status,["in progress", "completed", "cancelled"]

end
