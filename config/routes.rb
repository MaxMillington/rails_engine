Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'customers/random',                   to: 'customers#random'
      get 'customers/find',                     to: 'customers#find'
      get 'customers/find_all',                 to: 'customers#find_all'
      get 'customers/:id/favorite_merchant',    to: 'customers#favorite_merchant'
      get 'customers/:id/invoi  ces',             to: 'customers#invoices'
      get 'customers/:id/transactions',         to: 'customers#transactions'
      resources :customers, only: [:show, :index]

      get 'merchants/random',                               to: 'merchants#random'
      get 'merchants/find',                                 to: 'merchants#find'
      get 'merchants/find_all',                             to: 'merchants#find_all'
      get 'merchants/most_revenue',                         to: 'merchants#most_revenue'
      get 'merchants/most_items',                           to: 'merchants#most_items'
      get 'merchants/revenue',                              to: 'merchants#total_merchant_revenue'
      get 'merchants/:id/items',                            to: 'merchants#items'
      get 'merchants/:id/customers',                        to: 'merchants#customers'
      get 'merchants/:id/transactions',                     to: 'merchants#transactions'
      get 'merchants/:id/invoices',                         to: 'merchants#invoices'
      get 'merchants/:id/revenue',                          to: 'merchants#revenue'
      get 'merchants/:id/favorite_customer',                to: 'merchants#favorite_customer'
      get 'merchants/:id/customers_with_pending_invoices',  to: 'merchants#customers_with_pending_invoices'
      resources :merchants, only: [:show, :index]

      get 'items/random',             to: 'items#random'
      get 'items/find',               to: 'items#find'
      get 'items/find_all',           to: 'items#find_all'
      get 'items/most_revenue',       to: 'items#most_revenue'
      get 'items/most_items',         to: 'items#most_items'
      get 'items/:id/merchant',       to: 'items#merchant'
      get 'items/:id/invoice_items',  to: 'items#invoice_items'
      get 'items/:id/invoices',       to: 'items#invoices'
      get 'items/:id/best_day',       to: 'items#best_day'
      resources :items, only: [:show, :index]

      get 'invoices/random',                to: 'invoices#random'
      get 'invoices/find',                  to: 'invoices#find'
      get 'invoices/find_all',              to: 'invoices#find_all'
      get 'invoices/:id/customer',          to: 'invoices#customer'
      get 'invoices/:id/merchant',          to: 'invoices#merchant'
      get 'invoices/:id/transactions',      to: 'invoices#transactions'
      get 'invoices/:id/invoice_items',     to: 'invoices#invoice_items'
      get 'invoices/:id/items', to: 'invoices#items'
      resources :invoices, only: [:show, :index]

      get 'invoice_items/random',                   to: 'invoice_items#random'
      get 'invoice_items/find',                     to: 'invoice_items#find'
      get 'invoice_items/find_all',                 to: 'invoice_items#find_all'
      get 'invoice_items/:id/invoice',              to: 'invoice_items#invoice'
      get 'invoice_items/:id/item',                 to: 'invoice_items#item'
      resources :invoice_items, only: [:show, :index]

      get 'transactions/random',                  to: 'transactions#random'
      get 'transactions/find',                    to: 'transactions#find'
      get 'transactions/find_all',                to: 'transactions#find_all'
      get 'transactions/:id/invoice',             to: 'transactions#invoice'
      resources :transactions, only: [:show, :index]
    end
  end
end
