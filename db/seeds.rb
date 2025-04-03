# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

ApplicationRecord.transaction do
  User.create!(
    email: 'admin@example.com',
    password: 'password',
    name: 'Admin',
    roles: [ 'admin' ],
    jti: '1234567890'
  )


  Client.create!(
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '1234567890',
    address: '123 Main St, Anytown, USA',
    city: 'Anytown',
    state: 'CA',
    zip: '12345'
  )


  Product.create!(
    name: 'Product 1',
    description: 'This is a test product',
    sku: '1234567890',
    quantity: 100,
    purchase_price: 50.00,
    sale_price: 150.00
  )


  Sale.create!(
    client_id: Client.first.id,
    seller_id: User.first.id,
    discount: 10.00,
    total_amount: 100.00,
    date: Date.today,
    status: Sale.statuses[:pending],
    payment_method: Sale.payment_methods[:cash]
  )

  SaleDetail.create!(
    sale_id: Sale.first.id,
    product_id: Product.first.id,
    quantity: 1,
    unit_price: 100.00,
    total_price: 100.00,
    discount: 10.00
  )
end
