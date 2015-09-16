class Invoice < ActiveRecord::Base
  validates :status, presence: true

  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items


  def self.successful
    joins(:transactions).where("result = 'success'")
  end

  def self.total_revenue(ids)
    {revenue: "%.2f" % (InvoiceItem.where(invoice_id: ids).
        map {|invoice_item| invoice_item.quantity * invoice_item.unit_price}.
        reduce(:+))}
  end

  def self.failed
    joins(:transactions).where(:transactions => {result: "failed"})
  end

  def self.pending_invoices(ids)
    Customer.where(id: ids)
  end

  def self.favorite_customer
    self.joins(:customer).group(:customer_id).
        count.sort_by {|key, value| [value, key]}.reverse.first.first
  end

end
