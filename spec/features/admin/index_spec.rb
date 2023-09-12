require "rails_helper"

RSpec.feature "the admin index page" do
  describe 'when visiting /admin' do
    it 'US19 shows a header indicating that we are on the admin dashboard' do

      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end
  end

  describe 'when visiting /admin' do
    it 'US20 shows a link to /admin/merchants and /admin/invoices' do

      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
      within (".links") do
        expect(page).to have_link("Merchants")
        expect(page).to have_link("Invoices")
        click_link("Merchants")
        expect(page).to have_current_path("/admin/merchants")
        visit "/admin"
        click_link("Invoices")
        expect(page).to have_current_path("/admin/invoices")
      end
    end
  end
end
    