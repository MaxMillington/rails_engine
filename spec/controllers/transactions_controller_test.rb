require 'rails_helper'

describe Api::V1::TransactionsController do
  context '#index' do
    it 'returns all the transactions' do
      merchant = Merchant.create(name: 'Max the Merchant')
      customer = Customer.create(first_name: 'Wes',
                                 last_name: 'Montgomery')
      invoice = Invoice.create(status: "paid", customer_id: customer.id,
                               merchant_id: merchant.id)
      transaction = Transaction.create(invoice_id: invoice.id,
                         result: "success", credit_card_number: "1234343")


      get :index, format: :json

      expect(response).to have_http_status(:ok)
      transactions = JSON.parse(response.body)
      expect(transactions.count).to eq(1)

      transaction = transactions.first
      expect(transaction['result']).to eq('success')
    end
  end

  context '#show' do
    it 'returns a transaction' do
      merchant = Merchant.create(name: 'Max the Merchant')
      customer = Customer.create(first_name: 'Wes',
                                 last_name: 'Montgomery')
      invoice = Invoice.create(status: "paid", customer_id: customer.id,
                               merchant_id: merchant.id)
      transaction = Transaction.create(invoice_id: invoice.id,
                                       result: "success", credit_card_number: "1234343")

      get :show, id: transaction.id, format: :json

      expect(response).to have_http_status(:ok)
      transaction = JSON.parse(response.body)

      expect(transaction['result']).to eq('sucess')
    end
  end

  context '#find and find_all' do
    it 'returns a transaction' do
      merchant = Merchant.create(name: 'Max the Merchant')
      customer = Customer.create(first_name: 'Wes',
                                 last_name: 'Montgomery')
      invoice = Invoice.create(status: "paid", customer_id: customer.id,
                               merchant_id: merchant.id)
      transaction = Transaction.create(invoice_id: invoice.id,
                                       result: "success", credit_card_number: "1234343")

      transaction2 = Transaction.create(invoice_id: invoice.id,
                                       result: "fail", credit_card_number: "12343434")

      get :find, id: transaction.id, format: :json

      expect(response).to have_http_status(:ok)
      transaction = JSON.parse(response.body)

      expect(transaction['result']).to eq('success')

      get :find_all, id: transaction2.id, format: :json

      expect(response).to have_http_status(:ok)
      transaction2 = JSON.parse(response.body)

      expect(transaction2.first['result']).to eq('fail')
    end
  end

  context '#invoice' do
    it 'returns invoice' do
      merchant = Merchant.create(name: 'Max the Merchant')
      customer = Customer.create(first_name: 'Wes',
                                 last_name: 'Montgomery')
      invoice = Invoice.create(status: "paid", customer_id: customer.id,
                               merchant_id: merchant.id)
      transaction = Transaction.create(invoice_id: invoice.id,
                                       result: "success", credit_card_number: "1234343")

      transaction2 = Transaction.create(invoice_id: invoice.id,
                                        result: "fail", credit_card_number: "12343434")

      get :invoice, id: transaction.id, format: :json

      expect(response).to have_http_status(:ok)
      invoice = JSON.parse(response.body)

      expect(invoice['status']).to eq('paid')

    end
  end

end