require "rails_helper"

RSpec.feature "the merchant bulk_discounts index page" do
  describe 'when visiting /merchants/merchant_id/bulk_discounts' do
    it '2US1 displays all discounts' do
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

      visit "/merchants/#{merchant.id}/bulk_discounts"

      expect(page).to have_content("#{discount_1.percentage_discount}%")
      expect(page).to have_content(discount_1.quantity_threshold)
      expect(page).to have_content("#{discount_2.percentage_discount}%")
      expect(page).to have_content(discount_2.quantity_threshold)

      within("tr#discount-#{discount_1.id}") do
        expect(page).to have_link("Show")
        click_link("Show")
      end

      expect(page).to have_current_path("/merchants/#{merchant.id}/bulk_discounts/#{discount_1.id}")
    end

    it '2US2 shows a button to create a new discount' do
      merchant = create(:merchant)

      visit "/merchants/#{merchant.id}/bulk_discounts"

      expect(page).to have_button("Create New Discount")
      click_button("Create New Discount")
      expect(page).to have_current_path("/merchants/#{merchant.id}/bulk_discounts/new")
    end

    it '2US3 shows a button to delete a discount' do
      merchant = create(:merchant)
      discount_1 = merchant.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 5)

      visit "/merchants/#{merchant.id}/bulk_discounts"
      
      within("tr#discount-#{discount_1.id}") do
        expect(page).to have_button("Delete")
        click_button("Delete")
      end

      expect(page).to have_current_path("/merchants/#{merchant.id}/bulk_discounts")
      expect(page).to_not have_content("#{discount_1.percentage_discount}%")
      expect(page).to_not have_content(discount_1.quantity_threshold)
    end
  end
end
