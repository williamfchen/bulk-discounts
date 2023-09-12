require "rails_helper"

RSpec.feature "the merchant invoices index page" do
  describe 'when visiting /merchants/merchant_id/invoices' do
    xit 'US14 displays a list of merchant invoices with a button to each invoice show page' do
      merchant = Merchant.create!(name: "Bracelets 'n Stuff")
      item = merchant.items.create!(name: "Bracelet", description: "Shiny", unit_price: 100)
      

      visit "/merchants/#{merchant.id}/invoices"

      expect(page).to have_button(invoice_1.id)

      expect(button(invoice_1.id)).to have_path "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"
    end
  end
end
