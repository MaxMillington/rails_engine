class Api::V1::InvoicesController < ApplicationController
  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def random
    respond_with Invoice.order("RANDOM()").first
  end

  def find
    respond_with Invoice.find_by(find_params)
  end

  def find_all
    respond_with Invoice.where(find_params)
  end

  private

  def find_params
    params.permit(:id, :customer_id, :merchant_id, :status)
  end

end