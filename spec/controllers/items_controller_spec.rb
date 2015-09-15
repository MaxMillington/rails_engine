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
end