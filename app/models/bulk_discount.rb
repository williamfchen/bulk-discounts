class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :percentage_discount, presence: true, numericality: { greater_than: 0, less_than: 100 }
  validates :min_quantity, presence: true, numericality: { greater_than: 0 }
end