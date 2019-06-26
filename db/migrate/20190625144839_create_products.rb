class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.string :slug
      t.decimal :price, precision: 10, scale: 2
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
