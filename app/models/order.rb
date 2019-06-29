class Order < ApplicationRecord
	before_destroy :no_referenced_items

	has_many :items
	belongs_to :user

	accepts_nested_attributes_for :items, allow_destroy: true

	def subtotals  
	   self.items.map { |i| i.subtotal }  
	end  
	
	def total_all  
	   subtotals.sum  
	end

	def no_referenced_items
		return items.empty?

		errors.add_to_base("This customer is referenced by order(s): #{items.map(&:number).to_sentence}")
    	false # If you return anything else, the callback will not stop the destroy from happening
	end

	def can_destory
		return items.empty?
	end
end
