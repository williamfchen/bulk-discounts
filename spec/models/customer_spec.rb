require 'rails_helper'

RSpec.describe Customer, type: :model do 
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name)}
  end

  describe "#top_customers" do
    it "should find the top 5 customers who have the largest number of successful transactions" do

    customer_1 = Customer.create(first_name: "Joey", last_name:"One")
    customer_2 = Customer.create(first_name: "John", last_name:"Two")
    customer_3 = Customer.create(first_name: "Joselyn", last_name:"Three")
    customer_4 = Customer.create(first_name: "Jerry", last_name:"Four")
    customer_5 = Customer.create(first_name: "Jackson", last_name:"Five")
    customer_6 = Customer.create(first_name: "Jojo", last_name:"Six")

    invoice_1 = Invoice.create(customer: customer_1, status: 1)
    invoice_2 = Invoice.create(customer: customer_1, status: 1)
    invoice_3 = Invoice.create(customer: customer_2, status: 1)
    invoice_4 = Invoice.create(customer: customer_2, status: 1)
    invoice_5 = Invoice.create(customer: customer_2, status: 1)
    invoice_6 = Invoice.create(customer: customer_3, status: 1)
    invoice_7 = Invoice.create(customer: customer_4, status: 1)
    invoice_8 = Invoice.create(customer: customer_4, status: 1)
    invoice_9 = Invoice.create(customer: customer_4, status: 1)
    invoice_10 = Invoice.create(customer: customer_4, status: 1)
    invoice_11 = Invoice.create(customer: customer_4, status: 1)
    invoice_12 = Invoice.create(customer: customer_5, status: 1)
    invoice_13 = Invoice.create(customer: customer_5, status: 1)
    invoice_14 = Invoice.create(customer: customer_5, status: 1)
    invoice_15 = Invoice.create(customer: customer_5, status: 1)
    invoice_16 = Invoice.create(customer: customer_5, status: 1)
    invoice_17 = Invoice.create(customer: customer_5, status: 1)
    invoice_18 = Invoice.create(customer: customer_6, status: 1)
    invoice_19 = Invoice.create(customer: customer_6, status: 1)
    invoice_20 = Invoice.create(customer: customer_6, status: 1)
    invoice_21 = Invoice.create(customer: customer_6, status: 1)

    transaction_1 = Transaction.create(invoice: invoice_1, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_2 = Transaction.create(invoice: invoice_2, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_3 = Transaction.create(invoice: invoice_3, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_4 = Transaction.create(invoice: invoice_4, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_5 = Transaction.create(invoice: invoice_5, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_6 = Transaction.create(invoice: invoice_6, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_7 = Transaction.create(invoice: invoice_7, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_8 = Transaction.create(invoice: invoice_8, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_9 = Transaction.create(invoice: invoice_9, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_10 = Transaction.create(invoice: invoice_10, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_11 = Transaction.create(invoice: invoice_11, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_12 = Transaction.create(invoice: invoice_12, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_13 = Transaction.create(invoice: invoice_13, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_14 = Transaction.create(invoice: invoice_14, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_15 = Transaction.create(invoice: invoice_15, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_16 = Transaction.create(invoice: invoice_16, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_17 = Transaction.create(invoice: invoice_17, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_18 = Transaction.create(invoice: invoice_18, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_19 = Transaction.create(invoice: invoice_18, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_20 = Transaction.create(invoice: invoice_18, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    transaction_21 = Transaction.create(invoice: invoice_18, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
    
    expect(Customer.top_customer[0]).to eq(customer_5)
    expect(Customer.top_customer[0].transaction_count).to eq(6)
    expect(Customer.top_customer[1]).to eq(customer_4)
    expect(Customer.top_customer[1].transaction_count).to eq(5)
    expect(Customer.top_customer[2]).to eq(customer_6)
    expect(Customer.top_customer[2].transaction_count).to eq(4)
    expect(Customer.top_customer[3]).to eq(customer_2)
    expect(Customer.top_customer[3].transaction_count).to eq(3)
    expect(Customer.top_customer[4]).to eq(customer_1)
    expect(Customer.top_customer[4].transaction_count).to eq(2)
    end
  end
end
