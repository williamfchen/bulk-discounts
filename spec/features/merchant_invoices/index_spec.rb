require "rails_helper"

RSpec.feature "the merchant invoices index page" do
  describe 'when visiting /merchants/merchant_id/invoices' do
    it 'US14 displays a list of merchant invoices with a button to each invoice show page' do
      merchant = Merchant.create!(name: "Bracelets 'n Stuff")
      customer = Customer.create!(first_name: "Robert", last_name: "Redford")
      invoice_1 = merchant.invoices.create!(customer_id: customer.id, status: 0)

      visit "/merchants/#{merchant.id}/invoices"

      expect(page).to have_button(invoice_1.id)
  end
end
