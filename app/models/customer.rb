class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  #would this one beloew need to be through through(through items, through invoice_items)? Know what I mean? 
  # has_many :items, through: :invoices
end
