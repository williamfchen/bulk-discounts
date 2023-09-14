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
    it { should validate_presence_of :merchant_id }
    # it { should validate_presence_of :status }
  end

  describe instance_methods do 
    it "#formatted_ unit_price" do
      merchant = Merchant.create!(name: "Bracelets 'n Stuff")
      item = merchant.items.create!(name: "Bracelet", description: "Shiny", unit_price: 1000)

      expect(item.formatted_unit_price).to eq("$10.00")
    end
  end

  describe 'class methods' do
    describe '#popular_items' do
      it 'returns the top 5 items by total revenue generated' do
        merchant = create(:merchant)
        customer = create(:customer)
        item1 = create(:item, merchant: merchant, unit_price: 100)
        item2 = create(:item, merchant: merchant, unit_price: 200)
        item3 = create(:item, merchant: merchant, unit_price: 300)
        item4 = create(:item, merchant: merchant, unit_price: 400)
        item5 = create(:item, merchant: merchant, unit_price: 500)
        item6 = create(:item, merchant: merchant, unit_price: 600)

        invoice1 = create(:invoice, customer: customer)
        invoice2 = create(:invoice, customer: customer)

        # Create invoice items and transactions
        create(:invoice_item, invoice: invoice1, item: item1, quantity: 1, unit_price: 100)
        create(:invoice_item, invoice: invoice1, item: item2, quantity: 2, unit_price: 200)
        create(:invoice_item, invoice: invoice1, item: item3, quantity: 3, unit_price: 300)
        create(:invoice_item, invoice: invoice2, item: item4, quantity: 4, unit_price: 400)
        create(:invoice_item, invoice: invoice2, item: item5, quantity: 5, unit_price: 500)
        create(:invoice_item, invoice: invoice2, item: item6, quantity: 6, unit_price: 600)

        create(:transaction, invoice: invoice1, result: 'success')
        create(:transaction, invoice: invoice2, result: 'success')

        result = Invoice.popular_items

        expect(result.map(&:id)).to eq([item6.id, item5.id, item4.id, item3.id, item2.id])
      end
    end
  end
end