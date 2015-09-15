class InvoiceItem < ActiveRecord::Base
  validates :unit_price, presence: true
  validates :quantity,   presence: true

  belongs_to :invoice
  belongs_to :item
end
