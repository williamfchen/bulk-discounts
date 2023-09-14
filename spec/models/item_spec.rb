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
      it 'US 12 returns the top 5 items by total revenue generated' do
        merchant = create(:merchant)

        item1 = create(:item, merchant: merchant)
        item2 = create(:item, merchant: merchant)
        item3 = create(:item, merchant: merchant)
        item4 = create(:item, merchant: merchant)
        item5 = create(:item, merchant: merchant)
        item6 = create(:item, merchant: merchant)
        
        invoice1 = create(:invoice)
        invoice2 = create(:invoice)
        invoice3 = create(:invoice)
        
        create(:invoice_item, item: item1, invoice: invoice1, quantity: 5, unit_price: 100)
        create(:invoice_item, item: item2, invoice: invoice1, quantity: 3, unit_price: 200)
        create(:invoice_item, item: item3, invoice: invoice2, quantity: 4, unit_price: 150)
        create(:invoice_item, item: item4, invoice: invoice2, quantity: 6, unit_price: 100)
        create(:invoice_item, item: item5, invoice: invoice3, quantity: 2, unit_price: 300)
        create(:invoice_item, item: item6, invoice: invoice3, quantity: 1, unit_price: 500)
        
        create(:transaction, invoice: invoice1, result: 'success')
        create(:transaction, invoice: invoice2, result: 'success')
        create(:transaction, invoice: invoice3, result: 'success')

        revenues = {
          item1 => 5 * 100,
          item2 => 3 * 200,
          item3 => 4 * 150,
          item4 => 6 * 100,
          item5 => 2 * 300,
          item6 => 1 * 500
        }

        expect(Item.popular_items).to eq(revenues.sort_by { |_, revenue| -revenue }.first(5).map(&:first))
      end
    end
  end
end