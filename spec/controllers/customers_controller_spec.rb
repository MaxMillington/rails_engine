require 'rails_helper'

describe Api::V1::CustomersController do
  context '#index' do
    it 'returns all the customers' do
      Customer.create(first_name: 'Wes',
                      last_name: 'Montgomery')

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      customers = JSON.parse(response.body)
      expect(customers.count).to eq(1)

      customer = customers.first
      expect(customer['first_name']).to eq('Wes')
    end
  end

  context '#show' do
    it 'returns a customer' do
      customer = Customer.create(first_name: 'Pat',
                                 last_name: 'Martino')

      get :show, id: customer.id, format: :json

      expect(response).to have_http_status(:ok)
      customer = JSON.parse(response.body)

      expect(customer['first_name']).to eq('Pat')
    end
  end

  context '#find and find_all' do
    it 'returns customers' do
      customer = Customer.create(first_name: 'John',
                                 last_name: 'McLaughlin')
      customer2 = Customer.create(first_name: 'Tad',
                                  last_name: 'Farlow')

      get :find, id: customer.id, format: :json

      expect(response).to have_http_status(:ok)
      customer = JSON.parse(response.body)

      expect(customer['first_name']).to eq('John')

      get :find_all, id: customer2.id, format: :json

      expect(response).to have_http_status(:ok)
      customer2 = JSON.parse(response.body)

      expect(customer2.first['first_name']).to eq('Tad')
    end
  end

  context '#invoices' do
    it 'returns invoices' do
      customer = Customer.create(first_name: 'John',
                                 last_name: 'McLaughlin')

      merchant = Merchant.create(name: 'Max the Merchant')

      invoice = Invoice.create(customer_id: customer.id,
                               merchant_id: merchant.id, status: "paid")

      get :invoices, format: :json, id: customer.id

      expect(response).to have_http_status(:ok)

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(1)
      
      invoice = invoices.first
      expect(invoice['status']).to eq('paid')

    end
  end

  context '#transactions' do
    it 'returns transactions' do

    end
  end

end