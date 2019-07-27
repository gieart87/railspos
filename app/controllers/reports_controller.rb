class ReportsController < ApplicationController
	before_action :current_menu

	def sales
		@current_sub_menu = 'sales'
		@items = Item.select('orders.order_date','products.sku','products.name','items.qty').joins(:order).joins(:product).where('orders.status = 2').order('orders.order_date DESC').paginate(page: params[:page], per_page: 10)
	end

	def revenue
		@current_sub_menu = 'revenue'
		@orders = Order.select('DATE(orders.order_date) AS test',' SUM(orders.grand_total) as grand_total')
		.where(status:2)
		.group('order_date')
		.paginate(page: params[:page], per_page: 10)
		

		@orders.each do | order |
			raise order.inspect
		end
	end

	private
		def current_menu
			@current_menu = 'reports'
		end
end
