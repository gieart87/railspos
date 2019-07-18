class CreatePayments < ActiveRecord::Migration[5.2]
	def change
    	create_table :payments do |t|
			t.datetime :payment_date
			t.decimal :amount
			t.decimal :change_amount
			t.belongs_to :order, foreign_key: true

			t.timestamps
		end
	end
end
