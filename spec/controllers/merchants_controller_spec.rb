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

end