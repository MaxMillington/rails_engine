require 'rails_helper'

describe Api::V1::MerchantsController do
  context '#index' do
    it 'returns all the merchants' do
      Merchant.create(name: 'Max the Merchant')

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      merchants = JSON.parse(response.body)
      expect(merchants.count).to eq(1)

      merchant = merchants.first
      expect(merchant['name']).to eq('Max the Merchant')
    end
  end

  context '#show' do
    it 'returns a merchant' do
      merchant = Merchant.create(name: 'Max the Merchant')

      get :show, id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)
      merchant = JSON.parse(response.body)

      expect(merchant['name']).to eq('Max the Merchant')
    end
  end

  context '#find and find_all' do
    it 'returns a merchant' do
      merchant = Merchant.create(name: 'Max the Merchant')
      merchant2 = Merchant.create(name: 'Max the Merchant2')

      get :find, id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)
      merchant = JSON.parse(response.body)

      expect(merchant['name']).to eq('Max the Merchant')

      get :find_all, id: merchant2.id, format: :json

      expect(response).to have_http_status(:ok)
      merchant2 = JSON.parse(response.body)

      expect(merchant2.first['name']).to eq('Max the Merchant2')
    end
  end

  context '#items' do
    it 'returns items' do
      customer = Customer.create(first_name: 'John',
                                 last_name: 'McLaughlin')

      merchant = Merchant.create(name: 'Max the Merchant')

      invoice = Invoice.create(customer_id: customer.id,
                               merchant_id: merchant.id, status: "paid")

      item = Item.create(name: 'Monkeys',
                         description: 'Be careful with these mischievous monkeys.',
                         unit_price: 67.99, merchant_id: merchant.id)

      invoice_item = InvoiceItem.create(quantity: 4, unit_price: 54.99,
                                        invoice_id: invoice.id, item_id: item.id)

      get :items, id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)

      items = JSON.parse(response.body)
      expect(items.count).to eq(1)

      item = items.first
      expect(item['name']).to eq('Monkeys')
    end
  end

  context '#invoices' do
    it 'returns invoices' do
      customer = Customer.create(first_name: 'John',
                                 last_name: 'McLaughlin')

      merchant = Merchant.create(name: 'Max the Merchant')

      invoice = Invoice.create(customer_id: customer.id,
                               merchant_id: merchant.id, status: "paid")

      item = Item.create(name: 'Monkeys',
                         description: 'Be careful with these mischievous monkeys.',
                         unit_price: 67.99, merchant_id: merchant.id)

      invoice_item = InvoiceItem.create(quantity: 4, unit_price: 54.99,
                                        invoice_id: invoice.id, item_id: item.id)

      get :invoices, id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)

      invoices = JSON.parse(response.body)
      expect(invoices.count).to eq(1)

      invoice = invoices.first
      expect(invoice['status']).to eq("paid")
    end
  end

  context '#customers' do
    it 'returns customers' do
      customer = Customer.create(first_name: 'John',
                                 last_name: 'McLaughlin')

      merchant = Merchant.create(name: 'Max the Merchant')

      invoice = Invoice.create(customer_id: customer.id,
                               merchant_id: merchant.id, status: "paid")

      item = Item.create(name: 'Monkeys',
                         description: 'Be careful with these mischievous monkeys.',
                         unit_price: 67.99, merchant_id: merchant.id)

      invoice_item = InvoiceItem.create(quantity: 4, unit_price: 54.99,
                                        invoice_id: invoice.id, item_id: item.id)

      get :customers, id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)

      customers = JSON.parse(response.body)
      expect(customers.count).to eq(1)

      customer = customers.first
      expect(customer['first_name']).to eq("John")
    end
  end

  context '#transactions' do
    it 'returns transactions' do
      customer = Customer.create(first_name: 'John',
                                 last_name: 'McLaughlin')
      merchant = Merchant.create(name: 'Max the Merchant')

      invoice = Invoice.create(customer_id: customer.id,
                               merchant_id: merchant.id, status: "paid")
      item = Item.create(name: 'Monkeys',
                         description: 'Be careful with these mischievous monkeys.',
                         unit_price: 67.99, merchant_id: merchant.id)
      invoice_item = InvoiceItem.create(quantity: 4, unit_price: 54.99,
                                        invoice_id: invoice.id, item_id: item.id)
      transaction = Transaction.create(invoice_id: invoice.id,
                         result: "success", credit_card_number: "1234343")

      get :transactions, id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)

      transactions = JSON.parse(response.body)
      expect(transactions.count).to eq(1)

      transaction = transactions.first
      expect(transaction['result']).to eq("success")
    end
  end
end