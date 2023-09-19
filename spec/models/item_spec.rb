require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end

  describe instance_methods do 
    it "#formatted_ unit_price" do
      merchant = Merchant.create!(name: "Bracelets 'n Stuff")
      item = merchant.items.create!(name: "Bracelet", description: "Shiny", unit_price: 1000)

      expect(item.formatted_unit_price).to eq("$10.00")
    end

    describe "#total_revenue" do
      it 'returns the total revenue for an item' do
        merchant = create(:merchant)
        item = create(:item, merchant: merchant, unit_price: 1000)
        customer = create(:customer)
        invoice = customer.invoices.create!(status: 1)
        invoice_item = create(:invoice_item, item: item, invoice: invoice, quantity: 2, unit_price: 1000)
        transaction = create(:transaction, invoice: invoice, result: 1)

        expect(item.total_revenue).to eq("$20.00")
      end
    end
  end
end