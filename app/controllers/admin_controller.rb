class AdminController < ApplicationController
  def index
    @customers = Customer.all
    @invoices = Invoice.all
    # response = Faraday.get("https://api.unsplash.com/photos/MCO0-A98XQw/?client_id=EF3XCM-B_GVNzvSJL-tVaaXIFOgGxl99QvZTTIO0Ve8")
    # @photo = JSON.parse(response.body, symbolize_names: true)
  end
end

