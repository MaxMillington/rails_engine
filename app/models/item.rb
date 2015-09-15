class Item < ActiveRecord::Base
  validates :name,        presence: true
  validates :description, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def best_day
    invoices.successful.group('invoices.created_at')
        .sum('quantity * unit_price').
        sort_by {|x| x.last}.reverse.first
  end

end
