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

    it "US9/US10 buttons to enable/disable an item" do
      merchant_1 = Merchant.create!(name: "Bracelets 'n Stuff")
      item_1 = merchant_1.items.create!(name: "Bracelet", description: "Shiny", unit_price: 1000, status: 0)

      visit merchant_items_path(merchant_1)
    
      within "#disabled_items" do
        within "#merchant_item-#{item_1.id}" do
          expect(page).to have_content(item_1.name)
          expect(item_1.status).to eq("disabled")
          expect(page).to have_content("disabled")
          expect(page).to have_button("Enable Item")
          expect(page).to have_button("Disable Item")
          click_button("Enable Item")
          expect(current_path).to eq(merchant_items_path(merchant_1))
          item_1.reload
        end
      end

      within "#enabled_items" do
        within "#merchant_item-#{item_1.id}" do
          expect(page).to have_content(item_1.name)
          expect(item_1.status).to eq("enabled")
          expect(page).to have_content("enabled")
          expect(page).to have_button("Enable Item")
          expect(page).to have_button("Disable Item")
          click_button("Disable Item")
          item_1.reload
        end
      end

      within "#disabled_items" do
        within "#merchant_item-#{item_1.id}" do
          expect(page).to have_content(item_1.name)
          expect(item_1.status).to eq("disabled")
          expect(page).to have_content("disabled")
          expect(page).to have_button("Enable Item")
          expect(page).to have_button("Disable Item")
        item_1.reload
        end
      end
    end

    it "US11 has a link to create a new item" do
      visit merchant_items_path(@merchant_1)

      click_button "Create New Item"

      expect(current_path).to eq(new_merchant_item_path(@merchant_1))
    end
    
    #Will - I don't think this test is necessary.  It's covered in the model test
    context 'popular_items scenario' do
      before :each do
        @merchant = create(:merchant)
        @items = create_list(:item, 6, merchant: @merchant)
        @invoices = create_list(:invoice, 3)
        
        @invoice_items_data = [
          { item: @items[0], invoice: @invoices[0], quantity: 4, unit_price: 100 },
          { item: @items[1], invoice: @invoices[0], quantity: 1, unit_price: 200 },
          { item: @items[2], invoice: @invoices[1], quantity: 8, unit_price: 150 },
          { item: @items[3], invoice: @invoices[1], quantity: 6, unit_price: 100 },
          { item: @items[4], invoice: @invoices[2], quantity: 7, unit_price: 300 },
          { item: @items[5], invoice: @invoices[2], quantity: 1, unit_price: 500 }
        ]
        
        @invoice_items_data.each do |data|
          create(:invoice_item, data)
        end
        
        @invoices.each do |invoice|
          create(:transaction, invoice: invoice, result: 'success')
        end
      end
      
      it 'US12 displays the top 5 most popular items by revenue' do
        visit merchant_items_path(@merchant)

        within "#most_popular_items" do
          expect(page).to have_content(@items[0].name)
          expect(page).to_not have_content(@items[1].name)
          expect(page).to have_content(@items[2].name)
          expect(page).to have_content(@items[3].name)
          expect(page).to have_content(@items[4].name)
          expect(page).to have_content(@items[5].name)
          expect(page).to have_content(@items[0].total_revenue)
          expect(page).to_not have_content(@items[1].total_revenue)
          expect(page).to have_content(@items[2].total_revenue)
          expect(page).to have_content(@items[3].total_revenue)
          expect(page).to have_content(@items[4].total_revenue)
          expect(page).to have_content(@items[5].total_revenue)
        end
      end
    end
  end
end