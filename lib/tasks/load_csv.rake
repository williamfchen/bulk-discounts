require 'csv'

namespace :load_csv do
  desc "Load customers csv"
  task :customers => :environment do
    file_path = File.join(Rails.root, 'db', 'data', 'customers.csv')

    CSV.foreach(file_path, headers: true) do |row|
      Customer.create!(
        id: row['id'],
        first_name: row['first_name'],
        last_name: row['last_name'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      )
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE customers_id_seq RESTART WITH #{Customer.maximum(:id).to_i + 1}")
  end
end

namespace :load_csv do
  desc "Load invoices csv"
  task :invoices => :environment do
    file_path = File.join(Rails.root, 'db', 'data', 'invoices.csv')

    CSV.foreach(file_path, headers: true) do |row|
      Invoice.create!(
        id: row['id'],
        customer_id: row['customer_id'],
        status: row['status'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      )
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE invoices_id_seq RESTART WITH #{Invoice.maximum(:id).to_i + 1}")
  end
end

namespace :load_csv do
  desc "Load merchants csv"
  task :merchants => :environment do
    file_path = File.join(Rails.root, 'db', 'data', 'merchants.csv')

    CSV.foreach(file_path, headers: true) do |row|
      Merchant.create!(
        id: row['id'],
        name: row['name'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      )
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE merchants_id_seq RESTART WITH #{Merchant.maximum(:id).to_i + 1}")
  end
end

namespace :load_csv do
  desc "Load items csv"
  task :items => :environment do
    file_path = File.join(Rails.root, 'db', 'data', 'items.csv')

    CSV.foreach(file_path, headers: true) do |row|
      Item.create!(
        id: row['id'],
        name: row['name'],
        description: row['description'],
        unit_price: row['unit_price'],
        merchant_id: row['merchant_id'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      )
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE items_id_seq RESTART WITH #{Item.maximum(:id).to_i + 1}")
  end
end

namespace :load_csv do
  desc "Load transactions csv"
  task :transactions => :environment do
    file_path = File.join(Rails.root, 'db', 'data', 'transactions.csv')

    CSV.foreach(file_path, headers: true) do |row|
      Transaction.create!(
        id: row['id'],
        invoice_id: row['invoice_id'],
        credit_card_number: row['credit_card_number'],
        credit_card_expiration_date: row['credit_card_expiration_date'],
        result: row['result'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      )
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE transactions_id_seq RESTART WITH #{Transaction.maximum(:id).to_i + 1}")
  end
end

namespace :load_csv do
  desc "Load invoice items csv"
  task :invoice_items => :environment do
    file_path = File.join(Rails.root, 'db', 'data', 'invoice_items.csv')

    CSV.foreach(file_path, headers: true) do |row|
      InvoiceItem.create!(
        id: row['id'],
        item_id: row['item_id'],
        invoice_id: row['invoice_id'],
        quantity: row['quantity'],
        unit_price: row['unit_price'],
        status: row['status'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      )
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE invoice_items_id_seq RESTART WITH #{InvoiceItem.maximum(:id).to_i + 1}")
  end
end

namespace :load_csv do
  task :all => :environment do
    all = [:customers, :invoices, :merchants, :items, :transactions, :invoice_items]

    all.each do |file|
      Rake::Task["load_csv:#{file}"].invoke
    end

    puts "All Loaded"
  end
end
