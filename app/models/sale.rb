class Sale < ApplicationRecord
  enum :status, { pending: 0, paid: 1, cancelled: 2 }
  enum :payment_method, { cash: 0, card: 1, bank_transfer: 2 }

  belongs_to :client
  belongs_to :seller, class_name: "User"
  has_many :sale_details
  has_many :products, through: :sale_details

  validates :name, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :sale_details, allow_destroy: true

  def total_amount
    sale_details.inject(0) { |sum, detail| sum + detail.total_price }
  end
end
