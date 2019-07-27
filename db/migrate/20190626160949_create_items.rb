class CreateItems < ActiveRecord::Migration[5.2]
  	def change
		create_table :items do |t|
			t.belongs_to :product, foreign_key: true
			t.belongs_to :order, foreign_key: true
			t.integer :qty
			t.decimal :price, precision: 10, scale: 2
			t.decimal :discount, precision: 10, scale: 2

			t.timestamps
		end
  	end
end
