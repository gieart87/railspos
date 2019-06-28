class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :order_code
      t.datetime :order_date
      t.integer :status
      t.decimal :total, precision: 10, scale: 2
      t.decimal :discount, precision: 10, scale: 2

      t.timestamps
    end

    add_index :orders, :order_code, unique: true
  end
end
