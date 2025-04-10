class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    sales = Sale.all.as_json(only: [ :id, :total_amount, :created_at, :updated_at, :name, :description ])
    render json: { sales: sales }, status: :ok
  end

  def show
    sale = Sale.find(params[:id])
    render json: { sale: sale.as_json(include: [ sale_details: { include: [ :product ] }, seller: { only: [ :id, :name, :email, :roles ] } ]) }, status: :ok
  end

  def create
    sale = Sale.new(sale_params)
    if sale.save
      render json: { sale: sale.as_json(include: [ sale_details: { include: [ :product ] }, seller: { only: [ :id, :name, :email, :roles ] } ]) }, status: :created
    else
      render json: { errors: sale.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def update
    sale = Sale.find(params[:id])
    if sale.update(sale_params)
      render json: { sale: sale.as_json(include: [ sale_details: { include: [ :product ] }, seller: { only: [ :id, :name, :email, :roles ] } ]) }, status: :ok
    else
      render json: { errors: sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def sale_params
    params.require(:sale).permit(:name, :description, :total_amount, :payment_method, :status, :date, :client_id, :seller_id)
  end
end
