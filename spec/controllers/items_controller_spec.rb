require 'rails_helper'

describe Api::V1::ItemsController do
  context '#index' do
    it 'returns all the items' do
      merchant = Merchant.create(name: 'Max the Merchant')
      Item.create(name: 'Monkeys', description: 'Be very careful with these mischievous monkeys',
                  unit_price: 12.5, merchant_id: merchant.id)

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      items = JSON.parse(response.body)
      expect(items.count).to eq(1)

      item = items.first
      expect(item['name']).to eq('Monkeys')
      expect(item['description']).to eq('Be very careful with these mischievous monkeys')
    end
  end

  context '#show' do
    it 'returns a item' do
      merchant = Merchant.create(name: 'Max the Merchant')
      item = Item.create(name: 'Monkeys', description: 'Be very careful with these mischievous monkeys',
                  unit_price: 12.5, merchant_id: merchant.id)

      get :show, id: item.id, format: :json

      expect(response).to have_http_status(:ok)
      item = JSON.parse(response.body)

      expect(item['name']).to eq('Monkeys')
      expect(item['description']).to eq('Be very careful with these mischievous monkeys')
    end
  end

  context '#find and find_all' do
    it 'returns items' do
      merchant = Merchant.create(name: 'Max the Merchant')
      merchant2 = Merchant.create(name: 'Max the Merchant2')
      item = Item.create(name: 'Monkeys', description: 'Be very careful with these mischievous monkeys',
                         unit_price: 12.5, merchant_id: merchant.id)
      item2 = Item.create(name: 'Monkeys2', description: 'Be very careful with these mischievous monkeys',
                         unit_price: 12.52, merchant_id: merchant2.id)


      get :find, id: item.id, format: :json

      expect(response).to have_http_status(:ok)
      item = JSON.parse(response.body)

      expect(item['name']).to eq('Monkeys')

      get :find_all, id: item2.id, format: :json

      expect(response).to have_http_status(:ok)
      item2 = JSON.parse(response.body)

      expect(item2.first['name']).to eq('Monkeys2')

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

      get :invoices, id: item.id, format: :json
      expect(response).to have_http_status(:ok)

      invoices = JSON.parse(response.body)
      expect(invoices.count).to eq(1)

      invoice = invoices.first
      expect(invoice['status']).to eq('paid')

    end
  end

  context '#invoice_items' do
    it 'returns invoice items' do
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

      get :invoice_items, id: item.id, format: :json
      expect(response).to have_http_status(:ok)

      invoice_items = JSON.parse(response.body)
      expect(invoice_items.count).to eq(1)

      invoice_item = invoice_items.first

      expect(invoice_item['quantity']).to eq(4)

    end
  end

  context '#merchant' do
    it 'returns merchant' do
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

      get :merchant, id: item.id, format: :json
      expect(response).to have_http_status(:ok)

      merchant = JSON.parse(response.body)

      expect(merchant['name']).to eq('Max the Merchant')

    end
  end
end