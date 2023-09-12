require "rails_helper"

RSpec.feature "the admin/merchants index page" do
  describe 'when visiting /admin/merchants' do
    it 'shows a header for the page' do

      visit "/admin/merchants"

      expect(page).to have_content("Merchant Index")
    end
  end
end