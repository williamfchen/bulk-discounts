require "rails_helper"

RSpec.feature "the merchant discount show page" do
  describe 'when visiting /merchants/merchant_id/bulk_discounts/discount_id' do
    it '2US4 displays the discount and its attributes' do
      merchant = create(:merchant)
      discount_1 = merchant.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 5)

      visit "/merchants/#{merchant.id}/bulk_discounts/#{discount_1.id}"

      expect(page).to have_content("#{discount_1.percentage_discount}%")
      expect(page).to have_content(discount_1.quantity_threshold)
    end

    it '2US5 has a link to edit the discount' do
      merchant = create(:merchant)
      discount_1 = merchant.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 5)

      visit merchant_bulk_discount_path(merchant, discount_1)
      
      expect(page).to have_button("Edit")
      click_button("Edit")
      
      expect(page).to have_current_path("/merchants/#{merchant.id}/bulk_discounts/#{discount_1.id}/edit")
      expect(page).to have_field("Percentage Discount") 
      expect(page).to have_field("Quantity Threshold")
      
      fill_in "Percentage Discount", with: 20
      fill_in "Quantity Threshold", with: 40
      
      click_button("Update Discount")
      
      expect(page).to have_content("Bulk discount updated.")
      expect(page).to have_current_path("/merchants/#{merchant.id}/bulk_discounts/#{discount_1.id}")
      expect(page).to have_content(20)
      expect(page).to have_content(40)
    end
  end
end