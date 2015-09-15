require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { Customer.create(first_name: 'Django',
                                   last_name: 'Reinhardt') }
  let(:merchant) { Merchant.create(name: 'Max the Merchant') }
  let(:item) { Item.create(name: 'Monkeys',
                           description: 'Be careful with these mischievous monkeys.',
                           unit_price: 67.99, merchant_id: merchant.id) }
  let(:invoice) { Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "paid")}

  it 'is valid' do
    expect(customer).to be_valid
  end

  it 'is invalid without a first name' do
    customer.first_name = nil
    expect(customer).to_not be_valid
  end

  it 'is invalid without a last name' do
    customer.last_name = nil
    expect(customer).to_not be_valid
  end

  it 'returns the merchant' do
    Merchant.create(name: 'Max the Merchant')
    Invoice.create(customer_id: customer.id,
                   merchant_id: merchant.id, status: "paid")
    expect(customer.merchants.first).to eq(merchant)
  end

  it 'returns the invoice' do
    Merchant.create(name: 'Charles')
    invoice2 = Invoice.create(customer_id: customer.id,
                   merchant_id: merchant.id, status: "paid")
    expect(customer.invoices.first).to eq(invoice2)
  end

  it 'returns favorite merchant' do
    merchant = Merchant.create(name: 'Max the Merchant')
    merchant2 = Merchant.create(name: 'Mitch the Merchant')
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "paid")
    invoice2 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "paid")
    invoice3 = Invoice.create(customer_id: customer.id, merchant_id: merchant2.id, status: "paid")
    transaction = Transaction.create(invoice_id: invoice.id,
                       result: "success", credit_card_number: "1234343")
    transaction2 = Transaction.create(invoice_id: invoice2.id,
                                     result: "success", credit_card_number: "1234343")
    transaction3 = Transaction.create(invoice_id: invoice3.id,
                                     result: "success", credit_card_number: "1234343")

    expect(customer.favorite_merchant).to eq(merchant)
  end
end
