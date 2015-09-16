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
    respond_with Transaction.find_by(find_params)
  end

  def find_all
    respond_with Transaction.where(find_params)
  end

  def invoice
    respond_with Transaction.find_by(id: params[:id]).invoice
  end

  private

  def find_params
    params.permit(:id, :credit_card_number, :result,
                  :invoice_id, :created_at, :updated_at)
  end

end