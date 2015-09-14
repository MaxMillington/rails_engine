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
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find_all
    respond_with InvoiceItem.where(id: params[:id])
  end

end