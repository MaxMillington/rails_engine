class Api::V1::TransactionsController < ApplicationController
  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def random
    respond_with Transaction.order("RANDOM()").first
  end

  def find
    respond_with Transaction.find_by(id: params[:id])
  end

  def invoice
    respond_with Transaction.find_by(id: params[:id]).invoice
  end

end