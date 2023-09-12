require "rails_helper"

RSpec.feature "the admin/invoices index page" do
  describe 'when visiting /admin/invoices' do
    it 'shows a header for the page' do

      visit "/admin/invoices"

      expect(page).to have_content("Invoices Index")
    end
  end
end