class Payment < ApplicationRecord
	validates :order_id, presence: true
	validates :amount, presence: true

	belongs_to :order
end
