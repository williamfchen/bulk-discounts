class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  
  validates :name, presence: true

  def self.enabled
    where(enabled: true)
  end

  def self.disabled
    where(enabled: false)
  end
end
