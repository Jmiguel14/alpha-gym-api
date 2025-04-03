class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    sales = Sale.all.as_json(only: [ :id, :total_price, :created_at, :updated_at, :name, :description ])
    render json: { sales: sales }, status: :ok
  end

  def show
    sale = Sale.find(params[:id])
    render json: { sale: sale.as_json(include: [ :sale_details, seller: { only: [ :id, :name, :email, :roles ] } ]) }, status: :ok
  end
end
