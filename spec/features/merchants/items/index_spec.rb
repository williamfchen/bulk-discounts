require "rails_helper"

RSpec.feature "the merchant items index page" do
    before :each do
      @merchant_1 = Merchant.create!(name: "Bracelets 'n Stuff")
      @merchant_2 = Merchant.create!(name: "Necklaces 'n Stuff")
      @item_1 = @merchant_1.items.create!(name: "Bracelet", description: "Shiny", unit_price: 1000, status: 0)
      @item_2 = @merchant_1.items.create!(name: "Necklace", description: "Shiny", unit_price: 2000, status: 0)
      @item_3 = @merchant_2.items.create!(name: "Ring", description: "Shiny", unit_price: 3000, status: 0)
    end 

  describe 'when visiting /merchants/merchant_id/items' do
    it 'US6 displays a list of the merchants items' do

      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end

    it "US7 item has a link to go to an items show page" do 
      visit "/merchants/#{@merchant_1.id}/items"

      click_link "#{@item_1.name}"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.formatted_unit_price)
    end

    it "US9 buttons to enable/disable an item" do
      merchant_1 = Merchant.create!(name: "Bracelets 'n Stuff")
      item_1 = merchant_1.items.create!(name: "Bracelet", description: "Shiny", unit_price: 1000, status: 0)
      visit merchant_items_path(merchant_1)

      within "#disabled_items" do
        within "#merchant_item-#{@item_1.id}" do
          expect(page).to have_content(@item_1.name)
          expect(@item_1.status).to eq("disabled")
          expect(page).to have_content("disabled")
          expect(page).to have_button("Enable Item")
          expect(page).to have_button("Disable Item")
          click_button("Enable Item")
          expect(current_path).to eq(merchant_items_path(@merchant_1))
        @item_1.reload
        end
      end

      within "#enabled_items" do
        within "#merchant_item-#{@item_1.id}" do
          expect(page).to have_content(@item_1.name)
          expect(@item_1.status).to eq("enabled")
          expect(page).to have_content("enabled")
          expect(page).to have_button("Enable Item")
          expect(page).to have_button("Disable Item")
          click_button("Disable Item")
        @item_1.reload
        end
      end

      within "#disabled_items" do
        within "#merchant_item-#{@item_1.id}" do
          expect(page).to have_content(@item_1.name)
          expect(@item_1.status).to eq("disabled")
          expect(page).to have_content("disabled")
          expect(page).to have_button("Enable Item")
          expect(page).to have_button("Disable Item")
        @item_1.reload
        end
      end
    end
  end
end
