class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    search = Sale.sanitize_sql_like(params[:search] || "")
    if current_user.admin?
      sales = Sale.where("name ilike ?", "%#{search}%").order(date: :desc).as_json(only: [ :id, :total_amount, :created_at, :updated_at, :name, :description, :date ], methods: [ :total_amount ])
    else
      sales = Sale.where(seller_id: current_user.id).where("name ilike ?", "%#{search}%").order(date: :desc).as_json(only: [ :id, :total_amount, :created_at, :updated_at, :name, :description ], methods: [ :total_amount ])
    end
    render json: { sales: sales }, status: :ok
  end

  def show
    sale = Sale.find(params[:id])
    render json: { sale: sale.as_json(methods: [ :total_amount ], include: [ sale_details: { include: [ :product ] }, seller: { only: [ :id, :name, :email, :roles ] }, client: { only: [ :id, :name, :email ] } ]) }, status: :ok
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

  def destroy
    sale = Sale.find(params[:id])
    if sale.destroy
      render json: { message: "Sale deleted successfully" }, status: :ok
    else
      render json: { errors: sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def sale_params
    params.require(:sale).permit(
      :name, :description,
      :total_amount, :payment_method,
      :status, :date,
      :client_id, :seller_id,
      sale_details_attributes: [ :id, :product_id, :quantity, :unit_price, :total_price, :discount, :_destroy ])
  end
end
