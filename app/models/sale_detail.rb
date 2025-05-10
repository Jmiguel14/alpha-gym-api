class SaleDetail < ApplicationRecord
  belongs_to :sale
  belongs_to :product
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sale_id, presence: true
  validates :product_id, presence: true, uniqueness: { scope: :sale_id }

  after_commit :update_product_stock, on: :create
  after_commit :restore_product_stock, on: :destroy

  def update_product_stock
    product = Product.find(product_id)
    product.quantity -= quantity
    product.save
  end

  def restore_product_stock
    product = Product.find(product_id)
    product.quantity += quantity
    product.save
  end
end
