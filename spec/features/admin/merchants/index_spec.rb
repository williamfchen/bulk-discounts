require "rails_helper"
include ActionView::Helpers::NumberHelper
include ApplicationHelper

RSpec.feature "the admin/merchants index page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Queen Soopers", enabled: true)
    @merchant_2 = Merchant.create!(name: "Quick-E-Mart", enabled: true)
    @merchant_3 = Merchant.create!(name: "Veggi World", enabled: true)
    @merchant_4 = Merchant.create!(name: "Spatula City", enabled: true)
    @merchant_5 = Merchant.create!(name: "Just Rugs", enabled: false)
    @merchant_6 = Merchant.create!(name: "Ice Castle", enabled: false)
    @merchant_7 = Merchant.create!(name: "Flower Bin", enabled: false)

    @merchant_1_items = create_list(:item, 10, merchant: @merchant_1)
    @merchant_2_items = create_list(:item, 10, merchant: @merchant_2)
    @merchant_3_items = create_list(:item, 10, merchant: @merchant_3)
    @merchant_4_items = create_list(:item, 10, merchant: @merchant_4)
    @merchant_5_items = create_list(:item, 10, merchant: @merchant_5)
    @merchant_6_items = create_list(:item, 10, merchant: @merchant_6)
    @merchant_7_items = create_list(:item, 10, merchant: @merchant_7)

    @customer1 = Customer.create!(first_name: "Bob", last_name: "Smith")
    @customer2 = Customer.create!(first_name: "Jane", last_name: "Smith")
    @customer3 = Customer.create!(first_name: "John", last_name: "Smith")
    @customer4 = Customer.create!(first_name: "Janet", last_name: "Smith")
    @customer5 = Customer.create!(first_name: "Johnathan", last_name: "Smith")
    @customer6 = Customer.create!(first_name: "Johnny", last_name: "Smith")
    @customer7 = Customer.create!(first_name: "Joseph", last_name: "Smith")
    @customer8 = Customer.create!(first_name: "Smelly", last_name: "Cow")

    @customer1_invoices = create_list(:invoice, 5, customer: @customer1, created_at: Time.new(2014,6,5))
    @customer2_invoices = create_list(:invoice, 5, customer: @customer2, created_at: Time.new(1998,4,7))
    @customer3_invoices = create_list(:invoice, 5, customer: @customer3, created_at: Time.new(1900,7,6))
    @customer4_invoices = create_list(:invoice, 5, customer: @customer4, created_at: Time.new(1997,7,6))
    @customer5_invoices = create_list(:invoice, 5, customer: @customer5, created_at: Time.new(1987,5,4))
    @customer6_invoices = create_list(:invoice, 5, customer: @customer6, created_at: Time.new(2001,6,5))
    @customer7_invoices = create_list(:invoice, 5, customer: @customer7, created_at: Time.new(2003,7,6))

    @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: Time.new(2011,4,5))
    @invoice2 = Invoice.create!(status: "completed", customer_id: @customer2.id, created_at: Time.new(2012,3,4))
    @invoice3 = Invoice.create!(status: "completed", customer_id: @customer3.id, created_at: Time.new(2000,5,6))
    @invoice4 = Invoice.create!(status: "completed", customer_id: @customer4.id, created_at: Time.new(1999,5,6))
    @invoice5 = Invoice.create!(status: "completed", customer_id: @customer5.id, created_at: Time.new(2030,5,4))
    @invoice6 = Invoice.create!(status: "completed", customer_id: @customer6.id, created_at: Time.new(2012,5,4))
    @invoice7 = Invoice.create!(status: "completed", customer_id: @customer6.id, created_at: Time.new(2016,7,6))
    @invoice8 = Invoice.create!(status: "completed", customer_id: @customer8.id, created_at: Time.new(2015,5,3))

    @invoice_item1 = InvoiceItem.create!(invoice: @customer1_invoices[0], item: @merchant_1_items[0], status: 0, unit_price: 423, quantity: 4)
    @invoice_item2 = InvoiceItem.create!(invoice: @customer1_invoices[2], item: @merchant_1_items[4], status: 0, unit_price: 5463, quantity: 6)
    @invoice_item3 = InvoiceItem.create!(invoice: @customer1_invoices[3], item: @merchant_1_items[5], status: 0, unit_price: 543, quantity: 9)
    @invoice_item4 = InvoiceItem.create!(invoice: @customer1_invoices[1], item: @merchant_1_items[6], status: 0, unit_price: 543, quantity: 3)
    @invoice_item5 = InvoiceItem.create!(invoice: @customer2_invoices[0], item: @merchant_1_items[6], status: 0, unit_price: 54, quantity: 8)
    @invoice_item6 = InvoiceItem.create!(invoice: @customer2_invoices[1], item: @merchant_2_items[0], status: 0, unit_price: 7465, quantity: 4)
    @invoice_item7 = InvoiceItem.create!(invoice: @customer2_invoices[4], item: @merchant_2_items[3], status: 0, unit_price: 45322, quantity: 3)
    @invoice_item8 = InvoiceItem.create!(invoice: @customer3_invoices[0], item: @merchant_3_items[0], status: 0, unit_price: 76556, quantity: 2)
    @invoice_item9 = InvoiceItem.create!(invoice: @customer3_invoices[2], item: @merchant_3_items[3], status: 0, unit_price: 6453, quantity: 1)
    @invoice_item10 = InvoiceItem.create!(invoice: @customer3_invoices[4], item: @merchant_4_items[7], status: 0, unit_price: 4532, quantity: 8)
    @invoice_item11 = InvoiceItem.create!(invoice: @customer4_invoices[0], item: @merchant_4_items[7], status: 0, unit_price: 9876, quantity: 4)
    @invoice_item12 = InvoiceItem.create!(invoice: @customer4_invoices[3], item: @merchant_4_items[9], status: 0, unit_price: 4533, quantity: 4)
    @invoice_item13 = InvoiceItem.create!(invoice: @customer5_invoices[0], item: @merchant_5_items[0], status: 0, unit_price: 768, quantity: 8)
    @invoice_item14 = InvoiceItem.create!(invoice: @customer5_invoices[1], item: @merchant_5_items[1], status: 0, unit_price: 8765, quantity: 3)
    @invoice_item15 = InvoiceItem.create!(invoice: @customer5_invoices[4], item: @merchant_5_items[7], status: 0, unit_price: 7645, quantity: 4)
    @invoice_item16 = InvoiceItem.create!(invoice: @customer6_invoices[0], item: @merchant_6_items[0], status: 0, unit_price: 4623, quantity: 4)
    @invoice_item17 = InvoiceItem.create!(invoice: @customer6_invoices[1], item: @merchant_6_items[7], status: 0, unit_price: 6876, quantity: 4)
    @invoice_item18 = InvoiceItem.create!(invoice: @customer7_invoices[0], item: @merchant_6_items[8], status: 0, unit_price: 4265, quantity: 4)
    @invoice_item19 = InvoiceItem.create!(invoice: @customer7_invoices[3], item: @merchant_6_items[3], status: 0, unit_price: 97568, quantity: 4)
    @invoice_item20 = InvoiceItem.create!(invoice: @customer7_invoices[2], item: @merchant_7_items[3], status: 0, unit_price: 3254, quantity: 4)

    create(:transaction, invoice: @customer1_invoices[0], result: "success")
    create(:transaction, invoice: @customer1_invoices[2], result: "failed")
    create(:transaction, invoice: @customer1_invoices[3], result: "success")
    create(:transaction, invoice: @customer1_invoices[1], result: "success")
    create(:transaction, invoice: @customer2_invoices[0], result: "failed")
    create(:transaction, invoice: @customer2_invoices[1], result: "success")
    create(:transaction, invoice: @customer2_invoices[4], result: "success")
    create(:transaction, invoice: @customer3_invoices[0], result: "failed")
    create(:transaction, invoice: @customer3_invoices[2], result: "success")
    create(:transaction, invoice: @customer3_invoices[4], result: "success")
    create(:transaction, invoice: @customer4_invoices[0], result: "failed")
    create(:transaction, invoice: @customer4_invoices[3], result: "success")
    create(:transaction, invoice: @customer5_invoices[0], result: "success")
    create(:transaction, invoice: @customer5_invoices[1], result: "failed")
    create(:transaction, invoice: @customer5_invoices[4], result: "success")
    create(:transaction, invoice: @customer6_invoices[0], result: "failed")
    create(:transaction, invoice: @customer6_invoices[1], result: "success")
    create(:transaction, invoice: @customer7_invoices[0], result: "success")
    create(:transaction, invoice: @customer7_invoices[3], result: "success")
    create(:transaction, invoice: @customer7_invoices[2], result: "failed")
    create(:transaction, invoice: @customer7_invoices[2], result: "success")
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
        within("#merchant-#{@merchant_6.id}") do
          expect(page).to have_link("#{@merchant_6.name}", href: admin_merchant_path(@merchant_6))
          expect(page).to have_content("Total Revenue: #{number_to_currency(@merchant_6.total_revenue)}")
        end
  
        within("#merchant-#{@merchant_2.id}") do
          expect(page).to have_link("#{@merchant_2.name}", href: admin_merchant_path(@merchant_2))
          expect(page).to have_content("Total Revenue: #{number_to_currency(@merchant_2.total_revenue)}")
        end
  
        within("#merchant-#{@merchant_4.id}") do
          expect(page).to have_link("#{@merchant_4.name}", href: admin_merchant_path(@merchant_4))
          expect(page).to have_content("Total Revenue: #{number_to_currency(@merchant_4.total_revenue)}")
        end 
  
        within("#merchant-#{@merchant_5.id}") do
          expect(page).to have_link("#{@merchant_5.name}", href: admin_merchant_path(@merchant_5))
          expect(page).to have_content("Total Revenue: #{number_to_currency(@merchant_5.total_revenue)}")
        end
        
        within("#merchant-#{@merchant_7.id}") do
          expect(page).to have_link("#{@merchant_7.name}", href: admin_merchant_path(@merchant_7))
          expect(page).to have_content("Total Revenue: #{number_to_currency(@merchant_7.total_revenue)}")
        end

        expect(page).to_not have_link("#{@merchant_3.name}", href: admin_merchant_path(@merchant_3))
        expect(page).to_not have_content("Total Revenue: #{number_to_currency(@merchant_3.total_revenue)}")

        expect(@merchant_6.name).to appear_before(@merchant_2.name)
        expect(@merchant_2.name).to appear_before(@merchant_4.name)
        expect(@merchant_4.name).to appear_before(@merchant_5.name)
        expect(@merchant_5.name).to appear_before(@merchant_7.name)
      end
    end

    # 31. Admin Merchants: Top Merchant's Best Day
    it "shows the date with the most revenue for each merchant" do
      visit admin_merchants_path
      
      expect(page).to have_content("Top Five Merchants By Total Revenue")
  
      within("#top_five") do
        within("#merchant-#{@merchant_6.id}") do
          expect(page).to have_content("Top selling date for #{@merchant_6.name} was #{@merchant_6.best_day}")
        end
        
        within("#merchant-#{@merchant_2.id}") do
          expect(page).to have_content("Top selling date for #{@merchant_2.name} was #{@merchant_2.best_day}")
        end
        
        within("#merchant-#{@merchant_4.id}") do
          expect(page).to have_content("Top selling date for #{@merchant_4.name} was #{@merchant_4.best_day}")
        end 
        
        within("#merchant-#{@merchant_5.id}") do
          expect(page).to have_content("Top selling date for #{@merchant_5.name} was #{@merchant_5.best_day}")
        end
        
        within("#merchant-#{@merchant_7.id}") do
          expect(page).to have_content("Top selling date for #{@merchant_7.name} was #{@merchant_7.best_day}")
        end

      end
    end
  end
end
