class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  
  validates :name, presence: true
  validates :description, presence: true 
  validates :unit_price, presence: true
  validates :status, presence: true
  enum :status,["disabled", "enabled"]

  def formatted_unit_price
    dollars = unit_price / 100.0
    formatted = sprintf('%.2f', dollars)
    "$#{formatted}"
  end

  # this method is not used in the app, just the merchant items index feature spec
  def total_revenue
    revenue = invoice_items.sum('quantity * unit_price / 100.0')
    sprintf('$%.2f', revenue)
  end
end
