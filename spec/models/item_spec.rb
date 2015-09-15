require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { Customer.create(first_name: 'Django',
                                   last_name: 'Reinhardt') }
  let(:merchant) { Merchant.create(name: 'Max the Merchant') }
  let(:item) { Item.create(name: 'Monkeys',
                           description: 'Be careful with these mischievous monkeys.',
                           unit_price: 67.99, merchant_id: merchant.id) }
  let(:invoice) { Invoice.create(customer_id: customer.id,
                                 merchant_id: merchant.id, status: "paid")}
  let(:invoice_item) { InvoiceItem.create(quantity: 4, unit_price: 271.96,
                                          invoice_id: invoice.id, item_id: item.id)}
  let(:transaction) { Transaction.create(invoice_id: invoice.id,
                                         result: "success", credit_card_number: "1234343")}

  it 'is valid' do
    expect(item).to be_valid
  end

  it 'is invalid without name' do
    item.name = nil
    expect(item).to_not be_valid
  end

  it 'is invalid without description' do
    item.description = nil
    expect(item).to_not be_valid
  end

  it 'is returns the merchant' do
    expect(invoice.merchant).to eq(merchant)
  end

  it 'returns the invoice_item' do
    expect(invoice.customer).to eq(customer)
  end

  it 'returns the invoice_item' do

    invoice_item = InvoiceItem.create(quantity: 4, unit_price: 271.96,
                                      invoice_id: invoice.id, item_id: item.id)

    expect(item.invoice_items.first).to eq(invoice_item)
  end

  it 'returns the invoice' do
    invoice_item = InvoiceItem.create(quantity: 4, unit_price: 271.96,
                                      invoice_id: invoice.id, item_id: item.id)

    expect(item.invoices.first).to eq(invoice)
  end


  it 'returns the transaction' do
    transaction = Transaction.create(invoice_id: invoice.id,
                                     result: "success", credit_card_number: "1234343")

    expect(invoice.transactions.first).to eq(transaction)
  end

  it 'returns best day' do
    item = Item.create(name: 'Monkeys',
                             description: 'Be careful with these mischievous monkeys.',
                             unit_price: 67.99, merchant_id: merchant.id)
    invoice = Invoice.create(customer_id: customer.id,
                             merchant_id: merchant.id, status: "paid", created_at: "2012-03-25 13:54:11" )
    invoice2 = Invoice.create(customer_id: customer.id,
                             merchant_id: merchant.id, status: "paid", created_at: "2012-03-25 13:54:11")
    invoice3 = Invoice.create(customer_id: customer.id,
                             merchant_id: merchant.id, status: "paid", created_at: "2012-02-25 13:54:11")
    invoice_item = InvoiceItem.create(quantity: 4, unit_price: item.unit_price,
                                      invoice_id: invoice.id, item_id: item.id)
    invoice_item = InvoiceItem.create(quantity: 4, unit_price: item.unit_price,
                                      invoice_id: invoice2.id, item_id: item.id)
    invoice_item = InvoiceItem.create(quantity: 4, unit_price: item.unit_price,
                                      invoice_id: invoice3.id, item_id: item.id)
    transaction = Transaction.create(invoice_id: invoice.id,
                       result: "success", credit_card_number: "1234343")
    transaction2 = Transaction.create(invoice_id: invoice2.id,
                       result: "success", credit_card_number: "1234343")
    transaction3 = Transaction.create(invoice_id: invoice3.id,
                       result: "success", credit_card_number: "1234343")

    expect(item.best_day).to eq("2012-03-25 13:54:11")

  end
end
