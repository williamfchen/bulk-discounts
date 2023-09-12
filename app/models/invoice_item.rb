class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  validates :invoice_id, presence: true
  validates :item_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  enum :status,["packaged", "pending", "shipped"]
end
