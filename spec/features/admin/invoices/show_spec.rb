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
      expect(page).to have_content(invoice_1.status)
      expect(page).to have_content(invoice_1.created_at.strftime("%A, %B %d, %Y"))
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
      invoice_item_2 = InvoiceItem.create(item: item_2, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 1)
      visit admin_invoice_path(invoice_1.id)
      within(".items") do
        expect(page).to have_content("Items on this Invoice")
        expect(page).to have_content("Item Name")
        expect(page).to have_content("Quantity")
        expect(page).to have_content("Unit Price")
        expect(page).to have_content("Status")
        expect(page).to have_content(invoice_item_1.item.name)
        expect(page).to have_content(invoice_item_1.quantity)
        expect(page).to have_content("$343.43")
        expect(page).to have_content(invoice_item_1.status)
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
  end
end