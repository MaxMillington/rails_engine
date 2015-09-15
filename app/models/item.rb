class Item < ActiveRecord::Base
  validates :name,        presence: true
  validates :description, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
