require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
  end

  describe '#unit_price_to_decimal' do
    it "formats the unit price of an invoice item" do
      customer_1 = Customer.create(first_name: "Joey", last_name:"One")
      merchant_1 = Merchant.create(name: "merchant1")
      item_1 = Item.create(name: "item1", description: "1", unit_price: 2145, merchant: merchant_1)
      item_2 = Item.create(name: "item2", description: "1", unit_price: 2145, merchant: merchant_1)

      invoice_1 = Invoice.create(customer: customer_1, status: 0)

      invoice_item_1 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 0)
      invoice_item_2 = InvoiceItem.create(item: item_2, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 1)

      expect(invoice_item_1.unit_price_to_decimal).to eq(343.43)
    end
  end

  describe '#applicable_discount' do
    it '2US7 returns the total discounted revenue for an invoice' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      item_3 = create(:item, merchant: merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice, quantity: 5, unit_price: 100)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice, quantity: 2, unit_price: 200)
      invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice, quantity: 10, unit_price: 325)
      discount_1 = merchant.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 5)
      discount_2 = merchant.bulk_discounts.create!(percentage_discount: 50, quantity_threshold: 10)
      
      expect(invoice_item_1.applicable_discount).to eq(discount_1)
      expect(invoice_item_3.applicable_discount).to eq(discount_2)
    end
  end
end