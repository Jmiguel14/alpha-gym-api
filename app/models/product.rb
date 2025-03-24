class Product < ApplicationRecord
  validates :name, :description, :purchase_price, :sale_price, :sku, :quantity, presence: true
  validates :purchase_price, :sale_price, numericality: { greater_than: 0 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  has_many :sale_details
end
