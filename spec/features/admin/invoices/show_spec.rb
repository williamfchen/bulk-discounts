require "rails_helper"

RSpec.feature "the admin/invoices show page" do
  describe 'when visiting /admin/invoices show page' do
    it 'US 33 shows basic information for the invoice including number, status and customer info' do
      customer_1 = Customer.create(first_name: "Joey", last_name:"One")
      merchant_1 = Merchant.create(name: "merchant1")
      item_1 = Item.create(name: "item1", description: "1", unit_price: 2145, merchant: merchant_1)
      item_2 = Item.create(name: "item2", description: "1", unit_price: 2145, merchant: merchant_1)
  
      invoice_1 = Invoice.create(customer: customer_1, status: 0)
  
      invoice_item_1 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 0)
      invoice_item_2 = InvoiceItem.create(item: item_2, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 1)

      visit admin_invoice_path(invoice_1.id)

      expect(page).to have_content("Invoice ##{invoice_1.id}")
      expect(page).to have_content("Status: #{invoice_1.status.capitalize}")
      expect(page).to have_content("Created on: #{invoice_1.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Customer:")
      expect(page).to have_content("#{customer_1.first_name} #{customer_1.last_name}")
    end

    it 'US 34 shows item information for the invoice' do
      customer_1 = Customer.create(first_name: "Joey", last_name:"One")
      merchant_1 = Merchant.create(name: "merchant1")
      item_1 = Item.create(name: "item1", description: "1", unit_price: 2145, merchant: merchant_1)
      item_2 = Item.create(name: "item2", description: "1", unit_price: 2145, merchant: merchant_1)
  
      invoice_1 = Invoice.create(customer: customer_1, status: 0)
  
      invoice_item_1 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 0)
      invoice_item_2 = InvoiceItem.create(item: item_2, invoice: invoice_1, quantity: 23, unit_price: 343, status: 1)

      visit admin_invoice_path(invoice_1.id)
      within(".items") do
        expect(page).to have_content("Items on this Invoice")
        expect(page).to have_content("Item Name")
        expect(page).to have_content("Quantity")
        expect(page).to have_content("Unit Price")
        expect(page).to have_content("Status")
      end
        within("tr#items-#{invoice_item_1.id}") do
          expect(page).to have_content(invoice_item_1.item.name)
          expect(page).to have_content(invoice_item_1.quantity)
          expect(page).to have_content("$343.43")
          expect(page).to have_content(invoice_item_1.status)
        end
        within("tr#items-#{invoice_item_2.id}") do
          expect(page).to have_content(invoice_item_2.item.name)
          expect(page).to have_content(invoice_item_2.quantity)
          expect(page).to have_content("$3.43")
          expect(page).to have_content(invoice_item_2.status)
        end
    end

    it 'US 35 shows total revenue of invoice items (quantity * unit_price)' do
      customer_1 = Customer.create(first_name: "Joey", last_name:"One")
      merchant_1 = Merchant.create(name: "merchant1")
      item_1 = Item.create(name: "item1", description: "1", unit_price: 2145, merchant: merchant_1)
      item_2 = Item.create(name: "item2", description: "1", unit_price: 2145, merchant: merchant_1)
  
      invoice_1 = Invoice.create(customer: customer_1, status: 0)
  
      invoice_item_1 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 1, unit_price: 34343, status: 0)
      invoice_item_2 = InvoiceItem.create(item: item_2, invoice: invoice_1, quantity: 2, unit_price: 34343, status: 1)
      visit admin_invoice_path(invoice_1.id)

      expect(page).to have_content("Total Revenue: $1,030.29")
    end

    it "US 36 has a for to update the invoice status" do
      customer_1 = Customer.create!(first_name: "Bob", last_name: "Smith")
      invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id, created_at: Time.new(2011,4,5))

      visit admin_invoice_path(invoice_1)

      expect(page).to have_select(:status, with_options: ["in progress", "completed", "cancelled"], selected: "completed")
      expect(page).to have_button("Update Invoice Status")

      select("in progress", from: :status)
      click_button("Update Invoice Status")

      expect(current_path).to eq(admin_invoice_path(invoice_1))
      expect(page).to have_select(:status, selected: "in progress")
    end

    it '2US8 shows the total discounted revenue for an invoice' do
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
      
      visit admin_invoice_path(invoice)

      expect(page).to have_content("Total Discounted Revenue: $24.75")
    end
  end
end