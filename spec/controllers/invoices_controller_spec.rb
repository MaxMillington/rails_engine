require 'rails_helper'

describe Api::V1::InvoicesController do
  context '#index' do
    it 'returns all the invoices' do
      merchant = Merchant.create(name: 'Max the Merchant')
      customer = Customer.create(first_name: 'Wes',
                      last_name: 'Montgomery')
      Invoice.create(status: "paid", customer_id: customer.id,
                     merchant_id: merchant.id)

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      invoices = JSON.parse(response.body)
      expect(invoices.count).to eq(1)

      invoice = invoices.first
      expect(invoice['status']).to eq('paid')
    end
  end

  context '#show' do
    it 'returns a invoice' do
      merchant = Merchant.create(name: 'Max the Merchant')
      customer = Customer.create(first_name: 'Wes',
                                 last_name: 'Montgomery')
      invoice = Invoice.create(status: "paid", customer_id: customer.id,
                     merchant_id: merchant.id)

      get :show, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice = JSON.parse(response.body)

      expect(invoice['status']).to eq('paid')
    end
  end

  context '#find and find_all' do
    it 'returns an invoice' do
      merchant = Merchant.create(name: 'Max the Merchant')
      customer = Customer.create(first_name: 'Wes',
                                 last_name: 'Montgomery')
      invoice = Invoice.create(status: "paid", customer_id: customer.id,
                               merchant_id: merchant.id)
      invoice2 = Invoice.create(status: "paid", customer_id: customer.id,
                               merchant_id: merchant.id)

      get :find, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice = JSON.parse(response.body)

      expect(invoice['status']).to eq('paid')

      get :find_all, id: invoice2.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice2 = JSON.parse(response.body)

      expect(invoice2.first['status']).to eq('paid')
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

      get :transactions, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      transactions = JSON.parse(response.body)

    end
  end

  context '#invoice items' do
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
      transaction = Transaction.create(invoice_id: invoice.id,
                                       result: "success", credit_card_number: "1234343")

      get :invoice_items, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice_items = JSON.parse(response.body)
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
      transaction = Transaction.create(invoice_id: invoice.id,
                                       result: "success", credit_card_number: "1234343")

      get :items, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      items = JSON.parse(response.body)
    end
  end

  context '#customer' do
    it 'returns customer' do
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

      get :customer, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      customer = JSON.parse(response.body)

      expect(customer['first_name']).to eq('John')
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
      transaction = Transaction.create(invoice_id: invoice.id,
                                       result: "success", credit_card_number: "1234343")

      get :merchant, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      merchant = JSON.parse(response.body)
      expect(merchant['name']).to eq('Max the Merchant')
    end
  end

end