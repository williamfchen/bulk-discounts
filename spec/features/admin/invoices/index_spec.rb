require "rails_helper"

RSpec.feature "the admin/invoices index page" do
  describe 'when visiting /admin/invoices' do
    it 'shows a header for the page' do

      visit admin_invoices_path

      expect(page).to have_content("Invoices")
    end
  end

  describe 'when visiting /admin/invoices' do
    it 'I see a list of all invoice ids in the system, each id links to admin invoice show page' do
      customer_1 = Customer.create(first_name: "Joey", last_name:"One")
      merchant_1 = Merchant.create(name: "merchant1")
      item_1 = Item.create(name: "item1", description: "1", unit_price: 2145, merchant: merchant_1)
      item_2 = Item.create(name: "item2", description: "1", unit_price: 2145, merchant: merchant_1)
  
      invoice_1 = Invoice.create(customer: customer_1, status: 0)
      invoice_2 = Invoice.create(customer: customer_1, status: 1)
      invoice_3 = Invoice.create(customer: customer_1, status: 2)
  
      invoice_item_1 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 0)
      invoice_item_2 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 1)
      invoice_item_3 = InvoiceItem.create(item: item_1, invoice: invoice_2, quantity: 23, unit_price: 34343, status: 2)
      invoice_item_4 = InvoiceItem.create(item: item_1, invoice: invoice_2, quantity: 23, unit_price: 34343, status: 0)
      invoice_item_5 = InvoiceItem.create(item: item_1, invoice: invoice_3, quantity: 23, unit_price: 34343, status: 2)
      invoice_item_6 = InvoiceItem.create(item: item_2, invoice: invoice_3, quantity: 23, unit_price: 34343, status: 2)
      
      visit admin_invoices_path

      expect(page).to have_content("Invoices")
      expect(page).to have_content("Invoice ##{invoice_1.id}")
      expect(page).to have_content("Invoice ##{invoice_2.id}")
      expect(page).to have_content("Invoice ##{invoice_3.id}")
      expect(page).to have_link("#{invoice_1.id}")
      expect(page).to have_link("#{invoice_2.id}")
      expect(page).to have_link("#{invoice_3.id}")
      click_link("#{invoice_1.id}")
      expect(page).to have_current_path(admin_invoice_path(invoice_1.id))
      visit admin_invoices_path
      click_link("#{invoice_2.id}")
      expect(page).to have_current_path(admin_invoice_path(invoice_2.id))
      visit admin_invoices_path
      click_link("#{invoice_2.id}")
      expect(page).to have_current_path(admin_invoice_path(invoice_2.id))
    end
  end
end