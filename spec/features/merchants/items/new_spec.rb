require 'rails_helper'

RSpec.describe "Create new item form" do 
  before :each do
    @merchant_1 = Merchant.create!(name: "Bracelets 'n Stuff")
  end
  describe "new merchant item form" do
    it "US11 does not have any items created prior" do
      visit new_merchant_item_path(@merchant_1)

      expect(@merchant_1.items.count).to eq(0)
    end

    it "US11 has a form to create a new item" do
      visit new_merchant_item_path(@merchant_1)

      expect(page).to have_field(:name)
      expect(page).to have_field(:description)
      expect(page).to have_field(:unit_price)
      expect(page).to have_button("Create New Item")

      fill_in(:name, with: "Thing")
      fill_in(:description, with: "It's a thing")
      fill_in(:unit_price, with: 1000)
      click_button("Create New Item")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      expect(@merchant_1.items.count).to eq(1)
      expect(page).to have_content("Thing")
      expect(page).to have_content("It's a thing")
      expect(page).to have_content("$10.00")
    end

    it "US11 shows a flash message if the item is not created" do
      visit new_merchant_item_path(@merchant_1)

      expect(page).to have_field(:name)
      expect(page).to have_field(:description)
      expect(page).to have_field(:unit_price)
      expect(page).to have_button("Create New Item")

      fill_in(:name, with: "")
      fill_in(:description, with: "It's a thing")
      fill_in(:unit_price, with: 1000)
      click_button("Create New Item")

      expect(current_path).to eq(new_merchant_item_path(@merchant_1))
      expect(page).to have_content("Item not created: Required information missing.")

      fill_in(:name, with: "Thing")
      fill_in(:description, with: "")
      fill_in(:unit_price, with: "")
      click_button("Create New Item")

      expect(current_path).to eq(new_merchant_item_path(@merchant_1))
      expect(page).to have_content("Item not created: Required information missing.")
    end
  end
end