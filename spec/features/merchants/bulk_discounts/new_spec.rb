require "rails_helper"

RSpec.feature "the merchant discounts new page" do
  describe 'when visiting /merchants/merchant_id/bulk_discounts/new' do
    it '2US2 has a form to create a new discount' do
      merchant = create(:merchant)

      visit "/merchants/#{merchant.id}/bulk_discounts/new"

      expect(page).to have_field("Percentage Discount")
      expect(page).to have_field("Quantity Threshold")

      fill_in "Percentage Discount", with: 10
      fill_in "Quantity Threshold", with: 5
      click_button("Create Discount")

      expect(page).to have_current_path("/merchants/#{merchant.id}/bulk_discounts")
      expect(page).to have_content(10)
      expect(page).to have_content(5)
      expect(page).to have_content("Bulk discount created.")
    end
  end
end
