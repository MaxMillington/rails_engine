class Merchant < ActiveRecord::Base
  validates :name, presence: true

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  
  def self.most_revenue(params)

  end

  def self.most_items(params)

  end

  def self.most_merchant_revenue(params)

  end

  def revenue(date)

  end

  def favorite_customer

  end

  def customers_with_pending_invoices

  end

end
