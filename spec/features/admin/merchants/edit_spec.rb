require "rails_helper"

RSpec.describe "The Admin Merchants Edit Page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Queen Soopers")
    @merchant_2 = Merchant.create!(name: "Quick-E-Mart")
    @merchant_3 = Merchant.create!(name: "Veggi World")
    @merchant_4 = Merchant.create!(name: "Spatula City")
  end

  # User story 26
  describe "When I visit a merchant's admin show page" do
    it " hasa link to update the merchant's information" do
      visit admin_merchant_path(@merchant_1)

      click_link "Edit Queen Soopers"

      expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
    end
  end

  # User story 26.continued
  describe "When I click the link I am taken to a page to edit this merchant" do
    it "has a prepopulated form to edit this merchant" do
      visit edit_admin_merchant_path(@merchant_1)

      expect(page).to have_content("Update Merchant: Queen Soopers")
      expect(page).to have_field("Name", with: "Queen Soopers")
      fill_in("Name", with: "Market Queen")
      click_button "Submit"

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content("Merchant was successfully updated")
      expect(page).to have_content("Market Queen")
      expect(page).to_not have_content("Queen Soopers")
    end

    # User story 26.sad path
    it "throws error if name deleted/form submitted while blank" do
      visit edit_admin_merchant_path(@merchant_1)

      expect(page).to have_content("Update Merchant: Queen Soopers")
      expect(page).to have_field("Name", with: "Queen Soopers")
      fill_in("Name", with: "")
      click_button "Submit"

      expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
      expect(page).to have_content("Please fill in the name")
      expect(page).to have_content("Update Merchant: Queen Soopers")
    end
  end
end