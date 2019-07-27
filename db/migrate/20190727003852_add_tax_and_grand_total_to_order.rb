class AddTaxAndGrandTotalToOrder < ActiveRecord::Migration[5.2]
  	def change
		add_column :orders, :tax, :decimal, precision: 10, scale: 2, after: 'discount'
		add_column :orders, :grand_total, :decimal, precision: 10, scale: 2, after: 'tax'
  	end
end
