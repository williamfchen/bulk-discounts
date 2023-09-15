require "rails_helper"

RSpec.feature "the admin/merchants index page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Queen Soopers", enabled: true)
    @merchant_2 = Merchant.create!(name: "Quick-E-Mart", enabled: true)
    @merchant_3 = Merchant.create!(name: "Veggi World", enabled: true)
    @merchant_4 = Merchant.create!(name: "Spatula City", enabled: true)
    @merchant_5 = Merchant.create!(name: "Just Rugs", enabled: false)
    @merchant_6 = Merchant.create!(name: "Ice Castle", enabled: false)
  end

  describe 'when visiting /admin/merchants' do
    it 'shows a header for the page' do

      visit admin_merchants_path

      expect(page).to have_content("Merchant Index")
    end

    it "shows the name of each merchant in the system" do
      visit admin_merchants_path
      
      expect(page).to have_content("Merchant Name")
      expect(page).to have_content("#{@merchant_1.name}")
      expect(page).to have_content("#{@merchant_2.name}")
      expect(page).to have_content("#{@merchant_3.name}")
      expect(page).to have_content("#{@merchant_4.name}")
      
    end
    
    # 25. Admin Merchant Show
    it "merchant names are links to that merchant's show page" do
      visit admin_merchants_path
      
      expect(page).to have_link("Queen Soopers", href: admin_merchant_path(@merchant_1))
      expect(page).to have_link("Quick-E-Mart", href: admin_merchant_path(@merchant_2))
      expect(page).to have_link("Veggi World", href: admin_merchant_path(@merchant_3))
      expect(page).to have_link("Spatula City", href: admin_merchant_path(@merchant_4))
    end
    
    # 27. Admin Merchant Enable/Disable
    it "every merchant has a button to enable or disable that merchant" do
      visit admin_merchants_path

      within("tr#enabled-merchant-#{@merchant_1.id}") do
        expect(page).to have_content("Enabled")
        expect(page).to_not have_content("Disabled")
        expect(page).to have_button("Disable Merchant")
      end
  
      within("tr#enabled-merchant-#{@merchant_2.id}") do
        expect(page).to have_content("Enabled")
        expect(page).to_not have_content("Disabled")
        expect(page).to have_button("Disable Merchant")
      end
  
      within("tr#enabled-merchant-#{@merchant_3.id}") do
        expect(page).to have_content("Enabled")
        expect(page).to_not have_content("Disabled")
        expect(page).to have_button("Disable Merchant")
      end
  
      within("tr#enabled-merchant-#{@merchant_4.id}") do
        expect(page).to have_content("Enabled")
        expect(page).to_not have_content("Disabled")
        expect(page).to have_button("Disable Merchant")
      end
  
      within("tr#disabled-merchant-#{@merchant_5.id}") do
        expect(page).to have_content("Disabled")
        expect(page).to_not have_content("Enabled")
        expect(page).to have_button("Enable Merchant")
      end
  
      within("tr#disabled-merchant-#{@merchant_6.id}") do
        expect(page).to have_content("Disabled")
        expect(page).to_not have_content("Enabled")
        expect(page).to have_button("Enable Merchant")
      end
    end

    # 28. Admin Merchants Grouped by Status
    it "can enable or disable merchants and group them by status" do
      visit admin_merchants_path
  
      within(".enabled") do
        expect(page).to have_content("Enabled Merchants")
        expect(page).to have_content("Queen Soopers")
        expect(page).to have_content("Quick-E-Mart")
        expect(page).to have_content("Veggi World")
        expect(page).to have_content("Spatula City")
      end
      
      within(".disabled") do
        expect(page).to have_content("Disabled Merchants")
        expect(page).to have_content("Just Rugs")
        expect(page).to have_content("Ice Castle")
      end
  
      within("tr#enabled-merchant-#{@merchant_1.id}") do
        click_button("Disable Merchant")
      end
  
      within("tr#disabled-merchant-#{@merchant_5.id}") do
        click_button("Enable Merchant")
      end
  
      within(".enabled") do
        expect(page).to_not have_content("Queen Soopers")
        expect(page).to have_content("Just Rugs")
        expect(page).to have_content("Quick-E-Mart")
        expect(page).to have_content("Veggi World")
        expect(page).to have_content("Spatula City")
      end
  
      within(".disabled") do
        expect(page).to_not have_content("Just Rugs")
        expect(page).to have_content("Queen Soopers")
        expect(page).to have_content("Ice Castle")
      end
    end

    # User story 30
    it "has a section for top five merchants by total revenue" do
      visit admin_merchants_path
      
      expect(page).to have_content("Top Five Merchants By Total Revenue")

      within("#top_five") do
        within("#merchant-#{@merchant_1.id}") do
          expect(page).to have_link("#{@merchant_1.name}", href: admin_merchant_path(@merchant_1))
          expect(page).to have_content("Total Revenue: #{number_to_currency(@merchant_1.total_revenue)}")
        end
      end

    end
  end
end
