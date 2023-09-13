require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of :name}
  end

  before(:each) do
    @merchant_1 = Merchant.create!(name: "Queen Soopers", enabled: true)
    @merchant_2 = Merchant.create!(name: "Quick-E-Mart", enabled: true)
    @merchant_3 = Merchant.create!(name: "Veggi World", enabled: true)
    @merchant_4 = Merchant.create!(name: "Spatula City", enabled: true)
    @merchant_5 = Merchant.create!(name: "Just Powder", enabled: false)
    @merchant_6 = Merchant.create!(name: "Icee Freeze", enabled: false)
    @merchant_7 = Merchant.create!(name: "Water World", enabled: false)
  end

  describe "Class methods"
    it "returns all enabled merchants" do
      expect(Merchant.enabled).to eq([@merchant_1, @merchant_2, @merchant_3, @merchant_4])
    end

    it "returns all disabled merchants" do
      expect(Merchant.disabled).to eq([@merchant_5, @merchant_6, @merchant_7])
    end
end