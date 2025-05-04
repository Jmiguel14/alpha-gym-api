class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    search = Product.sanitize_sql_like(params[:search] || "")
    @products = Product.where("name ilike ?", "%#{search}%").order(:name)
    render json: @products, status: :ok
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    head :no_content
  end

  def product_params
    params.require(:product).permit(:name, :description, :purchase_price, :sale_price, :sku, :quantity)
  end
end
