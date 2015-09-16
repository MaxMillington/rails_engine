require 'csv'
require 'bigdecimal'

namespace :csv do
  desc "parse CSV data"

  task customers: :environment do
    csv_text = File.read('./public/CSV/customers.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create(row.to_h)
    end
  end

  task merchants: :environment do
    csv_text = File.read('./public/CSV/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Merchant.create(row.to_h)
    end
  end

  task items: :environment do
    csv_text = File.read('./public/CSV/items.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      Item.create(id: row[:id],
                  name: row[:name],
                  description: row[:description],
                  unit_price: BigDecimal.new(row[:unit_price].insert(-3, '.')),
                  merchant_id: row[:merchant_id],
                  created_at: row[:created_at],
                  updated_at: row[:updated_at])
    end
  end

  task invoices: :environment do
    csv_text = File.read('./public/CSV/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Invoice.create(row.to_h)
    end
  end

  task invoice_items: :environment do
    csv_text = File.read('./public/CSV/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      InvoiceItem.create(id: row[:id],
                         quantity: row[:quantity],
                         unit_price: BigDecimal.new(row[:unit_price].insert(-3, '.')),
                         item_id: row[:item_id],
                         invoice_id: row[:invoice_id],
                         created_at: row[:created_at],
                         updated_at: row[:updated_at])
    end
  end

  task transactions: :environment do
    csv_text = File.read('./public/CSV/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Transaction.create(row.to_h.except('credit_card_expiration_date'))
    end
  end
end