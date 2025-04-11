class SaleDetail < ApplicationRecord
  belongs_to :sale
  belongs_to :product
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sale_id, presence: true
  validates :product_id, presence: true, uniqueness: { scope: :sale_id }
end
