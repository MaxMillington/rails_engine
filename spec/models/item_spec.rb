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
  
end
