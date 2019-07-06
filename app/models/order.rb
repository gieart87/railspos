class Order < ApplicationRecord
	before_destroy :no_referenced_items
	before_create :set_order_code
	before_save :set_total

	has_many :items
	belongs_to :user

	accepts_nested_attributes_for :items, allow_destroy: true

	def sub_totals  
	   self.items.map { |i| i.subtotal }  
	end  
	
	def set_total  
	   self.total = sub_totals.sum  
	end

	def set_order_code
		self.order_code = generate_code
	end

	def no_referenced_items
		return items.empty?

		errors.add_to_base("This customer is referenced by order(s): #{items.map(&:number).to_sentence}")
    	false # If you return anything else, the callback will not stop the destroy from happening
	end

	def can_destory
		return items.empty?
	end

	private
		def generate_code
			chars = (0..9).to_a
			loop do
				order_code = (0...8).collect { chars[Kernel.rand(chars.length)] }.join
				break order_code unless Order.where(order_code: order_code).exists?
			end
		end
end
