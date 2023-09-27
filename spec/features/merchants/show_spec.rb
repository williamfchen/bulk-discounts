require "rails_helper"

RSpec.feature "the merchant show/dashboard page" do
  describe 'when visiting /merchants/merchant_id/dashboard' do
    it 'US1 shows the merchant name' do
      merchant = Merchant.create(name: "Bracelets 'n Stuff")

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_content(merchant.name)
    end

    it 'US2 displays a button for the merchants invoices and items' do
      merchant = Merchant.create(name: "Bracelets 'n Stuff")
      
      visit "/merchants/#{merchant.id}/dashboard"
      
      expect(page).to have_button("View Items")
      click_button("View Items")
      expect(page).to have_current_path("/merchants/#{merchant.id}/items")

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_button("View Invoices")
      click_button("View Invoices")
      expect(page).to have_current_path("/merchants/#{merchant.id}/invoices")
    end

    it "US3 displays the top 5 customers with successful transactions" do
      merchant_1 = Merchant.create(name: "Merchant 1")

      item_1 = Item.create(name: "Item 1", description: "Item 1 description", unit_price: 100, merchant_id: merchant_1.id)
  
      customer_1 = Customer.create(first_name: "Erica", last_name:"One")
      customer_2 = Customer.create(first_name: "Noelle", last_name:"Two")
      customer_3 = Customer.create(first_name: "Cory", last_name:"Three")
      customer_4 = Customer.create(first_name: "Terry", last_name:"Four")
      customer_5 = Customer.create(first_name: "Dani", last_name:"Five")
      customer_6 = Customer.create(first_name: "Juliet", last_name:"Six")
  
      invoice_1 = Invoice.create(customer_id: customer_1.id, status: 1)
      invoice_2 = Invoice.create(customer_id: customer_2.id, status: 1)
      invoice_3 = Invoice.create(customer_id: customer_3.id, status: 1)
      invoice_4 = Invoice.create(customer_id: customer_4.id, status: 1)
      invoice_5 = Invoice.create(customer_id: customer_5.id, status: 1)
      invoice_6 = Invoice.create(customer_id: customer_6.id, status: 1)
  
      invoice_items_1 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 100, status: 1)
      invoice_items_2 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 200, status: 1)
      invoice_items_3 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 300, status: 1)
      invoice_items_4 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_4.id, quantity: 3, unit_price: 300, status: 1)
      invoice_items_5 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 300, status: 1)
      invoice_items_6 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_6.id, quantity: 3, unit_price: 300, status: 1)
  
      transaction_1 = Transaction.create(invoice_id: invoice_1.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_2 = Transaction.create(invoice_id: invoice_2.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_3 = Transaction.create(invoice_id: invoice_2.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_4 = Transaction.create(invoice_id: invoice_3.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_5 = Transaction.create(invoice_id: invoice_3.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_6 = Transaction.create(invoice_id: invoice_3.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_7 = Transaction.create(invoice_id: invoice_4.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_8 = Transaction.create(invoice_id: invoice_4.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_9 = Transaction.create(invoice_id: invoice_4.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_10 = Transaction.create(invoice_id: invoice_4.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_11 = Transaction.create(invoice_id: invoice_5.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_12 = Transaction.create(invoice_id: invoice_5.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_13 = Transaction.create(invoice_id: invoice_5.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_14 = Transaction.create(invoice_id: invoice_5.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_15 = Transaction.create(invoice_id: invoice_5.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_16 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_17 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_18 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_19 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_20 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_21 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
      transaction_22 = Transaction.create(invoice_id: invoice_1.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 0)
      transaction_23 = Transaction.create(invoice_id: invoice_1.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 0)
      transaction_24 = Transaction.create(invoice_id: invoice_1.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 0)
      transaction_25 = Transaction.create(invoice_id: invoice_1.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 0)
      
      visit "/merchants/#{merchant_1.id}/dashboard"
      
      expect(page).to have_content("Top 5 Customers")
      within("#top5-customers") do
        within("#top5-#{customer_6.id}") do
          expect(page).to have_content(customer_6.first_name)
          expect(page).to have_content(customer_6.last_name)
          expect(page).to have_content(6)
        end
      end 

      within("#top5-customers") do
        expect(page).to_not have_content(customer_1.first_name)
        expect(page).to_not have_content(customer_1.last_name)
      end 
    end
  end

  it "US4 Items Ready to ship(items without 'shipped' status on invoice)" do
    @merchant = create(:merchant)
    @items = create_list(:item, 5, merchant: @merchant)
    @invoice_1 = create(:invoice, status: 1)
    @invoice_2 = create(:invoice, status: 1)
    @invoice_item_1 = create(:invoice_item, item: @items[0], invoice: @invoice_1, status: 0)
    @invoice_item_2 = create(:invoice_item, item: @items[1], invoice: @invoice_1, status: 1)
    @invoice_item_3 = create(:invoice_item, item: @items[2], invoice: @invoice_1, status: 1)
    @invoice_item_4 = create(:invoice_item, item: @items[3], invoice: @invoice_2, status: 1)
    @invoice_item_5 = create(:invoice_item, item: @items[4], invoice: @invoice_2, status: 2)

    visit dashboard_merchants_path(@merchant)

    within("#items_ready_to_ship") do
      expect(page).to have_content(@invoice_item_1.item.name)
      expect(page).to have_content(@invoice_item_2.item.name)
      expect(page).to have_content(@invoice_item_3.item.name)
      expect(page).to have_content(@invoice_item_4.item.name)
      expect(page).to_not have_content(@invoice_item_5.item.name)
    end
  end

  it "US4 has the invoice id linked to the invoice show page" do
    @merchant = create(:merchant)
    @items = create_list(:item, 5, merchant: @merchant)
    @invoice_1 = create(:invoice, created_at: "2012-03-27 14:54:09 UTC", status: 1)
    @invoice_2 = create(:invoice, created_at: "2013-05-21 14:54:09 UTC", status: 1)
    @invoice_item_1 = create(:invoice_item, item: @items[0], invoice: @invoice_1, status: 0)
    @invoice_item_2 = create(:invoice_item, item: @items[1], invoice: @invoice_1, status: 1)
    @invoice_item_3 = create(:invoice_item, item: @items[2], invoice: @invoice_1, status: 1)
    @invoice_item_4 = create(:invoice_item, item: @items[3], invoice: @invoice_2, status: 1)
    @invoice_item_5 = create(:invoice_item, item: @items[4], invoice: @invoice_2, status: 2)

    visit dashboard_merchants_path(@merchant)

    within("#items_ready_to_ship") do
      within("#ready_to_ship_item-#{@items[0].id}") do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_link("#{@invoice_1.id}")
      click_link("#{@invoice_1.id}")
      expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice_1))
      end
    end
  end

  it 'shows a link to view all discounts' do
    @merchant = create(:merchant)
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_button("View Bulk Discounts")

    click_button("View Bulk Discounts")

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
  end
end
