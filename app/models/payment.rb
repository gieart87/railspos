class Payment < ApplicationRecord
	validates :order_id, presence: true
	validates :amount, presence: true

	validate :valid_payment_amount

	belongs_to :order

	private
		def valid_payment_amount
			if self.amount < self.order.grand_total
				errors.add(:amount, :invalid_amount)
			end
		end
end

