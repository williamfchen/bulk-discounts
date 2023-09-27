class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  validates :customer_id, presence: true
  validates :status, presence: true

  enum :status,["in progress", "completed", "cancelled"]

  def self.incomplete_invoices
    Invoice
    .joins(:invoice_items)
    .select('invoices.*')
    .where.not('invoice_items.status = ?', 2)
    .group('invoices.id')
    .order(:created_at)
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity") / 100.0
  end

  def discounted_revenue
    InvoiceItem
    .select('quantity, unit_price, max_percentage')
    .from(
      invoice_items
      .joins(item: { merchant: :bulk_discounts })
      .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
      .select('quantity, invoice_items.unit_price as unit_price, max(bulk_discounts.percentage_discount) as max_percentage')
      .group('invoice_items.item_id, invoice_items.id')
    )
    .sum('quantity * unit_price * (max_percentage / 100.0) / 100')
  end

  def total_discounted_revenue
    total_revenue - discounted_revenue
  end
end
