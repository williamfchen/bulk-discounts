class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  validates :invoice_id, presence: true
  validates :item_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  enum :status,["packaged", "pending", "shipped"]

  def unit_price_to_decimal
    unit_price / 100.0
  end

  def applicable_discount
    item.merchant.bulk_discounts.where("#{quantity} >= quantity_threshold").order('percentage_discount DESC').first
  end
end