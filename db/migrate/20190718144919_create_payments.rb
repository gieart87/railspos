class CreatePayments < ActiveRecord::Migration[5.2]
	def change
    	create_table :payments do |t|
    		t.belongs_to :order, foreign_key: true
			t.datetime :payment_date
			t.decimal :amount, precision: 10, scale: 2
			t.decimal :change_amount, precision: 10, scale: 2

			t.timestamps
		end
	end
end
