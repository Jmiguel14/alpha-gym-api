class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :sales, foreign_key: :seller_id
  has_many :sale_details, through: :sales
  has_many :products, through: :sale_details
  has_many :clients, through: :sales

  def admin?
    roles.include?("admin")
  end

  def seller?
    roles.include?("seller")
  end

  def client?
    roles.include?("client")
  end

  def has_role?(role)
    roles.include?(role.to_s)
  end

  def total_sales_revenue
    current_beginning_of_month = Date.today.beginning_of_month
    current_end_of_month = Date.today.end_of_month
    sales.where(date: current_beginning_of_month..current_end_of_month).sum(:total_amount)
  end

  def total_products_purchase_price
    total_purchase_price = 0
    sale_details.each do |sale_detail|
      total_purchase_price += sale_detail.product.purchase_price * sale_detail.quantity
    end
    total_purchase_price
  end

  def net_profit
    total_sales_revenue - total_products_purchase_price
  end

  def commission
    net_profit * 0.2
  end
end
