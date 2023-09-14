class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  validates :name, presence: true

  def top_five_customers
    self.customers
      .select('customers.*, count(DISTINCT transactions.*) AS transaction_count')
      .where('transactions.result = 1')
      .joins(invoices: :transactions)
      .group('customers.id')
      .order(transaction_count: :desc)
      .limit(5)
  end
  
  def self.enabled
    where(enabled: true)
  end

  def self.disabled
    where(enabled: false)
  end

  def popular_items
    items.joins(invoice_items: { invoice: :transactions })
         .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) / 100.0 as revenue')
         .where('transactions.result = ?', 1)
         .group('items.id')
         .order('revenue DESC')
         .limit(5)
  end

  
end
