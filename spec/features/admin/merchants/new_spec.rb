require "rails_helper"

RSpec.describe "Admin merchant create page" do
  # 29. Admin Merchant Create
  it "has a link to create a new merchant on the merchants index page" do
    visit admin_merchants_path
    
    expect(page).to have_link("Create New Merchant", href: new_admin_merchant_path)
  end
  
  it "has a form that allows me to add new merchant information" do
    visit admin_merchants_path

    expect(page).to_not have_content("Klau Kalash")
    
    click_link("Create New Merchant")
    expect(page).to have_content("Create A New Merchant")
    expect(page).to have_field("Name")
    
    fill_in("Name", with: "Klau Kalash")
    click_button("Submit")
    
    expect(current_path).to eq(admin_merchants_path)
    
    within(".disabled") do
      expect(page).to have_content("Klau Kalash")
    end
    
    within(".enabled") do
      expect(page).to_not have_content("Klau Kalash")
    end
  end
  
  it "validates that Name is not blank" do
    visit new_admin_merchant_path
    
    click_button("Submit")
    expect(current_path).to eq(new_admin_merchant_path)
    expect(page).to have_content("Please fill in the name")
  end
end