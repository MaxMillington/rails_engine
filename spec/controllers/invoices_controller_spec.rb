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

end