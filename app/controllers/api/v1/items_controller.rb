class Api::V1::ItemsController < ApplicationController
  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def random
    respond_with Item.order("RANDOM()").first
  end

  def find
    respond_with Item.find_by(find_params)
  end

  def find_all
    respond_with Item.where(find_params)
  end

  def merchant
    respond_with Item.find_by(id: params[:id]).merchant
  end

  def invoices
    respond_with Item.find_by(id: params[:id]).invoices
  end

  def invoice_items
    respond_with Item.find_by(id: params[:id]).invoice_items
  end

  def best_day
    respond_with Item.find_by(id: params[:id]).best_day
  end

  def most_items
    respond_with Item.most_items(params)
  end

  def most_revenue
    respond_with Item.most_revenue(params)
  end

  private

  def find_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end