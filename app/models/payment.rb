class Payment < ApplicationRecord
	validates :order_id, presence: true
	validates :amount, presence: true

	validate :valid_payment_amount

	before_save :set_change_amount

	belongs_to :order

	def set_change_amount
		if (self.amount.to_f > self.order.grand_total)
			self.change_amount = self.amount - self.order.grand_total
		end
	end

	def save_payment
		save_status = false
		ActiveRecord::Base.transaction do
			if self.save
				self.order.update_order_and_stock
				save_status = true
			end
		end

		return save_status
	end

	private
		def valid_payment_amount
			if self.amount.to_f < self.order.grand_total
				errors.add(:amount, :invalid_amount)
			end
		end
end

