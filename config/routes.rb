Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'customers/random',                   to: 'customers#random'
      get 'customers/find',                     to: 'customers#find'
      get 'customers/find_all',                 to: 'customers#find_all'
      resources :customers, only: [:show, :index] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end

      get 'merchants/random',                               to: 'merchants#random'
      get 'merchants/find',                                 to: 'merchants#find'
      get 'merchants/find_all',                             to: 'merchants#find_all'
      resources :merchants, only: [:show, :index] do
        resources :items,     only: [:index]
        resources :invoices,  only: [:index]
      end

      get 'items/random',             to: 'items#random'
      get 'items/find',               to: 'items#find'
      get 'items/find_all',           to: 'items#find_all'
      resources :items, only: [:show, :index]

      get 'invoices/random',                to: 'invoices#random'
      get 'invoices/find',                  to: 'invoices#find'
      get 'invoices/find_all',              to: 'invoices#find_all'
      resources :invoices, only: [:show, :index] do
        resources :transactions, only: [:index]
        resources :invoice_items, only: [:index]
        resources :items, only: [:index]
        resources :merchant, only: [:show]
        resources :customer, only: [:show]
      end


      get 'invoice_items/random',                   to: 'invoice_items#random'
      get 'invoice_items/find',                     to: 'invoice_items#find'
      get 'invoice_items/find_all',                 to: 'invoice_items#find_all'
      get 'invoice_items/:invoice_item_id/invoice', to: 'invoices#show'
      get 'invoice_items/:invoice_item_id/item',    to: 'items#show'
      resources :invoice_items, only: [:show, :index] do
        resources :invoice_items, only: [:index]
        resources :merchant, only: [:show]
      end

      get 'transactions/random',                  to: 'transactions#random'
      get 'transactions/find',                    to: 'transactions#find'
      get 'transactions/find_all',                to: 'transactions#find_all'
      resources :transactions, only: [:show, :index] do
        resources :invoice, only: [:show]
      end
    end
  end
end
