class CreateProduct < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :sku
      t.decimal :purchase_price, precision: 10, scale: 2
      t.decimal :sale_price, precision: 10, scale: 2
      t.integer :quantity
      t.timestamps
    end
  end
end
