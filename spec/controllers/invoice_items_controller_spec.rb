require 'rails_helper'

describe Api::V1::InvoiceItemsController do
  context '#index' do
    it 'returns all the invoice Items' do
      merchant = Merchant.create(name: 'Max the Merchant')
      customer = Customer.create(first_name: 'Wes',
                                 last_name: 'Montgomery')
      item = Item.create(name: 'Monkeys', description: 'Be very careful with these mischievous monkeys',
                         unit_price: 12.5, merchant_id: merchant.id)
      invoice = Invoice.create(status: "paid", customer_id: customer.id,
                               merchant_id: merchant.id)
      invoice_item = InvoiceItem.create(quantity: 4, unit_price: 54.99,
                                        invoice_id: invoice.id, item_id: item.id)


      get :index, format: :json

      expect(response).to have_http_status(:ok)
      invoice_items = JSON.parse(response.body)
      expect(invoice_items.count).to eq(1)

      invoice_item = invoice_items.first
      expect(invoice_item['unit_price']).to eq('54.99')
    end
  end

  context '#show' do
    it 'returns a invoice' do
      merchant = Merchant.create(name: 'Max the Merchant')
      customer = Customer.create(first_name: 'Wes',
                                 last_name: 'Montgomery')
      item = Item.create(name: 'Monkeys', description: 'Be very careful with these mischievous monkeys',
                         unit_price: 12.5, merchant_id: merchant.id)
      invoice = Invoice.create(status: "paid", customer_id: customer.id,
                               merchant_id: merchant.id)
      invoice_item = InvoiceItem.create(quantity: 4, unit_price: 54.99,
                                        invoice_id: invoice.id, item_id: item.id)

      get :show, id: invoice_item.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice_item = JSON.parse(response.body)

      expect(invoice_item['unit_price']).to eq('54.99')
    end
  end

  context '#find and find_all' do
    it 'returns an invoice' do
      merchant = Merchant.create(name: 'Max the Merchant')
      customer = Customer.create(first_name: 'Wes',
                                 last_name: 'Montgomery')
      item = Item.create(name: 'Monkeys', description: 'Be very careful with these mischievous monkeys',
                         unit_price: 12.5, merchant_id: merchant.id)
      invoice = Invoice.create(status: "paid", customer_id: customer.id,
                               merchant_id: merchant.id)
      invoice_item = InvoiceItem.create(quantity: 4, unit_price: 54.99,
                                        invoice_id: invoice.id, item_id: item.id)

      invoice_item2 = InvoiceItem.create(quantity: 5, unit_price: 55.99,
                                         invoice_id: invoice.id, item_id: item.id)

      get :find, id: invoice_item.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice_item = JSON.parse(response.body)

      expect(invoice_item['unit_price']).to eq('54.99')

      get :find_all, id: invoice_item2.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice_item2 = JSON.parse(response.body)

      expect(invoice_item2.first['unit_price']).to eq('55.99')
    end
  end

  context '#invoice' do
    it 'returns invoice' do
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

      get :invoice, id: invoice_item.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice = JSON.parse(response.body)

      expect(invoice['status']).to eq("paid")

    end
  end

  context '#item' do
    it 'returns item' do
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

      get :item, id: invoice_item.id, format: :json

      expect(response).to have_http_status(:ok)
      item = JSON.parse(response.body)

      expect(item['name']).to eq("Monkeys")

    end
  end

  context '#random' do
    it 'returns a random ii' do
      invoice_item = InvoiceItem.create(quantity: 4, unit_price: 54.99,
                                        invoice_id: nil, item_id: nil)

      get :random,  format: :json

      expect(response).to have_http_status(:ok)

    end
  end

end