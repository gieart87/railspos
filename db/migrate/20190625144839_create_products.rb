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

			add_index :products, :sku, unique: true
			add_index :products, :name, unique: true
			add_index :products, :slug, unique: true
		end
  	end
end
