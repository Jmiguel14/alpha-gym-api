class CreateSaleDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :sale_details do |t|
      t.references :sale, null: false
      t.references :product, null: false
      t.integer :quantity
      t.decimal :discount, precision: 10, scale: 2
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
