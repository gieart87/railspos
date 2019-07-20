class Order < ApplicationRecord
	before_destroy :no_referenced_items
	before_create :set_order_code
	before_save :set_total

	has_many :items
	has_many :payments

	belongs_to :user

	accepts_nested_attributes_for :items, allow_destroy: true

	def sub_totals  
	   self.items.map { |i| i.sub_total }  
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
		return self.status == 1
	end

	def total_nett
		self.total.to_f - self.discount.to_f
	end

	def total_tax
		0.10 * total_nett
	end

	def grand_total
		total_nett + total_tax
	end

	def status_name
		case self.status
		when 1
			"Pending"
		when 2
			"Success"
		else 
			"Archived"
		end
	end

	private
		# def generate_code
		# 	chars = (0..9).to_a
		# 	loop do
		# 		order_code = (0...8).collect { chars[Kernel.rand(chars.length)] }.join
		# 		break order_code unless Order.where(order_code: order_code).exists?
		# 	end
		# end

		def generate_code
			date_code = DateTime.now.strftime('%Y%m%d')

			sql_last_code = "SELECT MAX(order_code) AS last_code FROM orders WHERE order_code LIKE '#{date_code}%' LIMIT 1"
			last_order_code = ActiveRecord::Base.connection.execute(sql_last_code).first[0]

			order_code = date_code + '0001'
			if !last_order_code.nil?
				last_order_number = last_order_code[8,4]
				next_order_number = '%04d' % (last_order_number.to_i + 1)
				order_code = date_code + next_order_number
			end
			
			return order_code
		end
end
