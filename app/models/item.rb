class Item < ActiveRecord::Base
  validates :name,        presence: true
  validates :description, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def best_day
    invoices.successful.group('invoices.created_at')
        .sum('quantity * unit_price').
        sort_by {|x| x.last}.reverse.first.first
  end

  def self.most_items(params)

  end

  def self.most_revenue(params)
    items_ids = Invoice.successful.joins(:items).group(:item_id).
        sum('quantity * invoice_items.unit_price').
        sort_by {|item_revenue_pair| item_revenue_pair.last}
        .reverse[0...(params[:quantity].to_i)].map(&:first)

    items_ids.map do |item_id|
      Item.find_by(id: item_id)
    end
  end

end
