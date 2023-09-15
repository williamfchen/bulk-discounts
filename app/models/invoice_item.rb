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
  
  # def self.successful_average_item_price
  #   InvoiceItem
  #     .joins(invoices: :transactions)
  #     .select('items.*, average(invoice_items.unit_price) as price')
  #     .where('transactions.result = ?', 1)
  # end

  # def self.successful_total_item_quantity
  #   InvoiceItem
  #     .joins(invoices: :transactions)
  #     .select('items.*, average(invoice_items.unit_price) as price')
  #     .where('transactions.result = ?', 1)
  # end
end


