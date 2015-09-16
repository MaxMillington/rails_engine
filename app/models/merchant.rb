class Merchant < ActiveRecord::Base
  validates :name, presence: true

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(params)
    sorted_merchants = all.sort_by do |merchant|
      merchant.invoices.successful.joins(:invoice_items).
          sum('quantity * unit_price')
    end

    sorted_merchants.reverse[0...(params[:quantity]).to_i]
  end

  def self.most_items(params)
    sorted_merchants = all.sort_by do |merchant|
      merchant.invoices.successful.joins(:invoice_items)
          .sum('quantity')
    end

    sorted_merchants.reverse[0...(params[:quantity]).to_i]
  end

  def self.merchant_revenue_by_date(params)
    {total_revenue: "%.2f" % Invoice.successful.where("invoices.created_at = '#{params[:date]}'").
        joins(:invoice_items).sum(('quantity * unit_price'))}
  end

  def success
    invoices.successful
  end

  def fail
    invoices.failed
  end

  def revenue(params)
    if params[:date]
      revenue_for_date(params[:date])
    else
      success.total_revenue(success.pluck(:id))
    end
  end

  def revenue_for_date(date)
    {revenue: "%.2f" % invoices.successful.where("invoices.created_at = '#{date}'")
        .joins(:invoice_items).sum('quantity * unit_price')}
  end

  def favorite_customer
    customer_ids = invoices.successful.group(:customer_id).
        count(:customer_id).sort_by{|customer_quantity_pair|
      customer_quantity_pair.last}.reverse.first

    customer_ids.map do |customer_id|
      Customer.find_by(id: customer_id)
    end
  end

  def customers_with_pending_invoices
    self.fail.pending_invoices(fail.pluck(:customer_id))
  end

end
