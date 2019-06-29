class Order < ApplicationRecord
	has_many :items
	belongs_to :user

	accepts_nested_attributes_for :items, allow_destroy: true

	def subtotals  
	   self.items.map { |i| i.subtotal }  
	end  
	
	def total_all  
	   subtotals.sum  
	end
end
