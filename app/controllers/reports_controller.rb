class ReportsController < ApplicationController
	before_action :current_menu

	def sales
		@current_sub_menu = 'sales'
		@items = Item.select(
			'DATE(orders.order_date) AS sales_date',
			'products.sku',
			'products.name',
			'SUM(items.qty) qty')
		.joins(:order).joins(:product)
		.where('orders.status = 2')
		.group('sales_date','products.id')
		.order('sales_date DESC')
		.paginate(page: params[:page], per_page: 10)
	end

	def revenue
		@current_sub_menu = 'revenue'
		@orders = Order.select('DATE(orders.order_date) AS revenue_date', ' SUM(orders.grand_total) as revenue_amount')
		.where(status:2)
		.group('revenue_date')
		.order('revenue_date ASC')
		.paginate(page: params[:page], per_page: 10)

	end

	private
		def current_menu
			@current_menu = 'reports'
		end
end
