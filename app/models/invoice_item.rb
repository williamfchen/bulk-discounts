class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  validates :invoice_id, presence: true
  validates :item_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  enum :status,["packaged", "pending", "shipped"]

  def formatted_unit_price
    dollars = unit_price / 100.0
    formatted = sprintf('%.2f', dollars)
    "$#{formatted}"
  end
end
