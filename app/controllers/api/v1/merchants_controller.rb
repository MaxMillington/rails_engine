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
    respond_with Merchant.find_by(id: params[:id])
  end

  def find_all
    respond_with Merchant.where(id: params[:id])
  end

end