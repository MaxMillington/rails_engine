class Api::V1::ItemsController < ApplicationController
  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def random
    respond_with Customer.order("RANDOM()").first
  end

  def find
    respond_with Customer.find_by(id: params[:id])
  end

  def find_all
    respond_with Customer.where(id: params[:id])
  end
end