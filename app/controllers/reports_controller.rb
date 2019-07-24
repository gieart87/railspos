class ReportsController < ApplicationController
	before_action :current_menu

	def sales
		@current_sub_menu = 'sales'
		@items = Item.select('orders.order_date','products.sku','products.name','items.qty').joins(:order).joins(:product).where('orders.status = 2').order('orders.order_date DESC').paginate(page: params[:page], per_page: 10)
	end

	def revenue
		@current_sub_menu = 'revenue'
	end

	private
		def current_menu
			@current_menu = 'reports'
		end
end
