class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.references :client, null: false
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.decimal :discount, precision: 10, scale: 2
      t.decimal :total_amount, precision: 10, scale: 2
      t.date :date
      t.string :name
      t.string :description
      t.integer :status, default: 0
      t.integer :payment_method, default: 0
      t.timestamps
    end
  end
end
