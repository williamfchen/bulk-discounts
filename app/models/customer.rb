class Customer < ApplicationRecord
  has_many :invoices
  #this one isn't many to many, I wonder if we'll need this set up for any US's?
  # has_many :transactions, through: :invoices
  #would this one beloew need to be through through(through items, through invoice_items)? Know what I mean? 
  # has_many :items, through: :invoices
  validates :first_name, presence: true
  validates :last_name, presence: true
end
