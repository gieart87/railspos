class Product < ApplicationRecord
	validates :sku, presence: true, uniqueness: true
	validates_format_of :sku, :with => /\A[a-zA-Z\d ]*\z/i, :message => "can only contain letters and numbers."

	validates :name, presence: true, uniqueness: true
	validates :price, presence: true
	validates :status, presence: true
end
