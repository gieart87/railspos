class Item < ApplicationRecord
	belongs_to :product
	belongs_to :order

	before_save :set_total, :set_price
	before_update :set_total, :set_price

	def set_total
		if self.qty.blank?
			0
		else
			self.total = self.qty * self.product.price
		end
	end

	def set_price
		self.price = self.product.price
	end
 	
	def subtotal
   		if self.qty.blank?
    		0
		else
			self.qty * self.product.price
		end
	end
end
