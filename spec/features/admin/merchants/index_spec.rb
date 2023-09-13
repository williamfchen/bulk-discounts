require "rails_helper"

RSpec.feature "the admin/merchants index page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Queen Soopers")
    @merchant_2 = Merchant.create!(name: "Quick-E-Mart")
    @merchant_3 = Merchant.create!(name: "Veggi World")
    @merchant_4 = Merchant.create!(name: "Spatula City")
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
  end
end