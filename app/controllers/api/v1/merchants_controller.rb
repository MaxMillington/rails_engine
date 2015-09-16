class Api::V1::MerchantsController < ApplicationController
  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def random
    respond_with Merchant.order("RANDOM()").first
  end

  def find
    respond_with Merchant.find_by(find_params)
  end

  def find_all
    respond_with Merchant.where(find_params)
  end

  def items
    respond_with Merchant.find_by(id: params[:id]).items
  end

  def invoices
    respond_with Merchant.find_by(id: params[:id]).invoices
  end

  def customers
    respond_with Merchant.find_by(id: params[:id]).customers
  end

  def transactions
    respond_with Merchant.find_by(id: params[:id]).transactions
  end

  def most_revenue
    respond_with Merchant.most_revenue(params)
  end

  def most_items
    respond_with Merchant.most_items(params)
  end

  def total_merchant_revenue_by_date
    respond_with Merchant.merchant_revenue_by_date(params)
  end

  def revenue
    respond_with Merchant.find_by(id: params[:id]).revenue
  end

  def favorite_customer
    respond_with Merchant.find_by(id: params[:id]).favorite_customer
  end

  def customers_with_pending_invoices
    respond_with Merchant.find_by(id: params[:id]).customers_with_pending_invoices
  end

  private

  def find_params
    params.permit(:id, :name, :created_at, :updated_at)
  end

end