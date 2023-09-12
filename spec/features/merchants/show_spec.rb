require "rails_helper"

RSpec.feature "the merchant show/dashboard page" do
  describe 'when visiting /merchants/merchant_id/dashboard' do
    it 'US1 shows the merchant name' do
      merchant = Merchant.create(name: "Bracelets 'n Stuff")

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_content(merchant.name)
    end

    it 'US2 displays a button for the merchants invoices and items' do
      merchant = Merchant.create(name: "Bracelets 'n Stuff")
      
      visit "/merchants/#{merchant.id}/dashboard"
      
      expect(page).to have_button("View Items")
      click_button("View Items")
      expect(page).to have_current_path("/merchants/#{merchant.id}/items")

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_button("View Invoices")
      click_button("View Invoices")
      expect(page).to have_current_path("/merchants/#{merchant.id}/invoices")
    end
  end
end
