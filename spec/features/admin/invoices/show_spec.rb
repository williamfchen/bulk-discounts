require "rails_helper"

RSpec.feature "the admin/invoices show page" do
  describe 'when visiting /admin/invoices show page' do
    it 'US 33 shows a header for the page' do
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
  end
end