require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  let(:customer) { Customer.create(first_name: 'Django',
                                   last_name: 'Reinhardt') }
  let(:merchant) { Merchant.create(name: 'Max the Merchant') }
  let(:item) { Item.create(name: 'Monkeys',
                           description: 'Be careful with these mischievous monkeys.',
                           unit_price: 67.99, merchant_id: merchant.id) }
  let(:invoice) { Invoice.create(customer_id: customer.id,
                                 merchant_id: merchant.id, status: "paid")}
  let(:invoice_item) {InvoiceItem.create(quantity: 4, unit_price: 271.96,
                                         invoice_id: invoice.id, item_id: item.id)}

  it 'is valid' do
    expect(invoice_item).to be_valid
  end

  it 'is invalid without unit price' do
    invoice_item.unit_price = nil
    expect(invoice_item).to_not be_valid
  end

  it 'is invalid without quantity' do
    invoice_item.quantity = nil
    expect(invoice_item).to_not be_valid
  end

  it 'returns the invoice' do
    expect(invoice_item.invoice).to eq(invoice)
  end

  it 'returns the item' do
    expect(invoice_item.item).to eq(item)
  end
end
