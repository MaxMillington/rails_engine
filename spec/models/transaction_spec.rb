require 'rails_helper'

RSpec.describe Transaction, type: :model do
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
    expect(transaction).to be_valid
  end

  it 'is returns the invoice' do
    expect(transaction.invoice).to eq(invoice)
  end

end
