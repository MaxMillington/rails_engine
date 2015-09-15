class Api::V1::InvoiceItemsController < ApplicationController
  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def random
    respond_with InvoiceItem.order("RANDOM()").first
  end

  def find
    respond_with InvoiceItem.find_by(find_params)
  end

  def find_all
    respond_with InvoiceItem.where(find_params)
  end

  private

  def find_params
    params.permit(:id, :invoice_id, :item_id, :quantity, :unit_price)
  end

end