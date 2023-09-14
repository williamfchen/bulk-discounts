require "rails_helper"

RSpec.describe "The Admin Merchants Show Page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Queen Soopers")
    @merchant_2 = Merchant.create!(name: "Quick-E-Mart")
    @merchant_3 = Merchant.create!(name: "Veggi World")
    @merchant_4 = Merchant.create!(name: "Spatula City")
  end

  describe "Name Link on the merchant index takes me to the show page for that merchant" do
    # User Story 25
    it "shows the name of that merchant" do
      visit admin_merchants_path

      click_link "Quick-E-Mart"
      expect(current_path).to eq(admin_merchant_path(@merchant_2))
      expect(page).to have_content("Merchant: Quick-E-Mart")
      expect(page).to_not have_content("Merchant: Queen Soopers")

      visit admin_merchants_path

      click_link "Spatula City"
      expect(current_path).to eq(admin_merchant_path(@merchant_4))
      expect(page).to have_content("Merchant: Spatula City")
      expect(page).to_not have_content("Merchant: Veggi World")
    end
  end
end