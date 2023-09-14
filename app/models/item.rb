class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  
  validates :name, presence: true
  validates :description, presence: true 
  validates :unit_price, presence: true
  validates :merchant_id, presence: true

  def formatted_unit_price
    dollars = unit_price / 100.0
    formatted = sprintf('%.2f', dollars)
    "$#{formatted}"
  end

  def self.popular_items
    Item
    .joins(:invoice_items)
    .joins(invoices: :transactions)
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .where('transactions.result = ?', 1)
    .group(:id)
    .order('revenue DESC')
    .limit(5)
  end

  # def successful_average_item_price
  #   .joins(:invoice_items)
  #   .joins(invoices: :transactions)
  #   .select('items.*, average(invoice_items.unit_price) as price')
  #   .where('transactions.result = ?', 1)
  # end

  # def successful_total_item_quantity
  #   .joins(:invoice_items)
  #   .joins(invoices: :transactions)
  #   .select('items.*, sum(invoice_items.quantity)')
  #   .where('transactions.result = ?', 1)
  # end
end
