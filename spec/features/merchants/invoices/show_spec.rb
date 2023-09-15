require "rails_helper"

RSpec.feature "the merchant invoices show page" do
  describe 'when visiting /merchants/merchant_id/invoices/:invoice_id' do
    it 'US15 displays the merchants invoice with details' do
      merchant = Merchant.create!(name: "Bracelets 'n Stuff")
      item = merchant.items.create!(name: "Bracelet", description: "Shiny", unit_price: 100)
      customer = Customer.create!(first_name: "Robert", last_name: "Redford")
      invoice = customer.invoices.create!(status: 0)
      invoice_item = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: 100, status: 0)

      visit "/merchants/#{merchant.id}/invoices/#{invoice.id}"

      expect(page).to have_content("ID: #{invoice.id}")
      expect(page).to have_content("Status: #{invoice.status}")
      expect(page).to have_content("Created At: #{invoice.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Customer Name: #{customer.first_name} #{customer.last_name}")
    end

    it 'US16 and 17 displays the item details of the invoice' do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant: merchant)
      invoice = create(:invoice)
      invoice_items_0 = create(:invoice_item, item: items[0], invoice: invoice)
      invoice_items_1 = create(:invoice_item, item: items[1], invoice: invoice)
      invoice_items_2 = create(:invoice_item, item: items[2], invoice: invoice)

      visit "/merchants/#{merchant.id}/invoices/#{invoice.id}"

      within "#invoice-item-#{invoice_items_0.id}" do
        expect(page).to have_content(items[0].name)
        expect(page).to have_content(invoice_items_0.quantity)
        expect(page).to have_content(invoice_items_0.unit_price / 100.00)
      end

      within "#invoice-item-#{invoice_items_1.id}" do
        expect(page).to have_content(items[1].name)
        expect(page).to have_content(invoice_items_1.quantity)
        expect(page).to have_content(invoice_items_1.unit_price / 100.00)
      end

      within "#invoice-item-#{invoice_items_2.id}" do
        expect(page).to have_content(items[2].name)
        expect(page).to have_content(invoice_items_2.quantity)
        expect(page).to have_content(invoice_items_2.unit_price / 100.00)
      end
      
      expect(page).to have_content("Total Revenue of Invoice: $#{invoice.total_revenue}")
    end
  end
end