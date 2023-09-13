require "rails_helper"

RSpec.feature "the merchant items index page" do
    before :each do
      @merchant_1 = Merchant.create!(name: "Bracelets 'n Stuff")
      @merchant_2 = Merchant.create!(name: "Necklaces 'n Stuff")
      @item_1 = @merchant_1.items.create!(name: "Bracelet", description: "Shiny", unit_price: 1000)
      @item_2 = @merchant_1.items.create!(name: "Necklace", description: "Shiny", unit_price: 2000)
      @item_3 = @merchant_2.items.create!(name: "Ring", description: "Shiny", unit_price: 3000)
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
  end
end
