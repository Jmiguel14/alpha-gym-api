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

  def net_profit(start_date, end_date)
    (total_sales_revenue(start_date, end_date) - total_products_purchase_price(start_date, end_date)).to_f
  end

  def total_sales_revenue(start_date, end_date)
    sales.where(date: start_date..end_date).sum(:total_amount)
  end

  def total_products_purchase_price(start_date, end_date)
    total_purchase_price = 0

    sale_details.joins(:sale).where(sales: { date: start_date..end_date }).each do |sale_detail|
      total_purchase_price += sale_detail.product.purchase_price * sale_detail.quantity
    end
    total_purchase_price
  end

  def commission(start_date, end_date)
    (net_profit(start_date, end_date) * 0.2).to_f
  end
end
