class OrdersController < ApplicationController
	load_and_authorize_resource

	before_action :set_order, only: [:show, :edit, :payment, :update, :destroy]
	before_action :lock_order, only: [:edit, :update, :destroy]
	before_action :check_order_items, only: [:create, :update]
	before_action :check_payment, only: [:payment]

	# GET /orders
	# GET /orders.json
	def index
		@orders = Order.all.order(order_date: :desc)
	end

	# GET /orders/1
	# GET /orders/1.json
	def show
	end

	# GET /orders/new
	def new
		@order = Order.new
		1.times { @order.items.build }
	end

	# GET /orders/1/edit
	def edit
	end

	# GET /orders/1/payment
	def payment
		@payment = Payment.new
	end

	# POST /orders
	# POST /orders.json
	def create
		@order = Order.new(order_params)
		@order.user_id = current_user.id
		@order.order_date = Time.now
		@order.status = 1

		respond_to do |format|
			if @order.save
				format.html { redirect_to @order, notice: 'Order was successfully created.' }
				format.json { render :show, status: :created, location: @order }
			else
				format.html { render :new }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /orders/1
	# PATCH/PUT /orders/1.json
	def update
		respond_to do |format|
			if @order.update(order_params.except(:order_date))
				format.html { redirect_to @order, notice: 'Order was successfully updated.' }
				format.json { render :show, status: :ok, location: @order }
			else
				format.html { render :edit }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	def save_payment
		@payment = Payment.new(payment_params)
		@payment.order_id = @order.id
		@payment.payment_date = Time.now

		respond_to do |format|
			if @payment.save
				@order.status = 2
				@order.save

				format.html { redirect_to @order, notice: 'Payment was successfully created.' }
				format.json { render :show, status: :created, location: @payment }
			else
				format.html { render :payment }
				format.json { render json: @payment.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /orders/1
	# DELETE /orders/1.json
	def destroy
		respond_to do |format|
			if @order.can_destory then
				@order.destroy
		
				flash[:notice] = 'Order was successfully destroyed.'
			else
				flash[:error] = 'Order could not be destroyed.'
			end

			format.html {redirect_to orders_url }
			format.json { head :no_content }
		end
	end

	private

		def set_order
			@order = Order.find(params[:id])
		end

		def order_params
			order_params = params.require(:order).permit(:order_code, :order_date, :status, :total, :discount, items_attributes: [:id,:product_id, :price,:qty,:total,:_destroy])
			
			if !order_params[:items_attributes].nil?
				order_params[:items_attributes].each do | key, item |
					if item[:qty].to_i < 1
						order_params[:items_attributes].delete(key)
					end
				end
			end

			return order_params
		end

		def payment_params
			params.require(:payment).permit(:amount, :change_amount)
		end

		def check_payment
			if @order.payments.sum(:amount) >= @order.grand_total
				respond_to do |format|
					flash[:error] = 'Order has been paid before'
					format.html { render :show }
				end
			end
		end

		def check_order_items
			item_numbers = 0

			errors = []

			if !order_params[:items_attributes].nil?
				order_params[:items_attributes].each do | key, item |
					 if !item[:product_id].empty?
					 	item_numbers += 1
					 	
					 	product = Product.find(item[:product_id])

					 	if product.stock < item[:qty].to_i
							errors.push("#{product.name} is out of stock")
						end
					 end
				end
			end

			if item_numbers < 1
				errors.push('At least one item chosen to make an order')
			end

			if errors.any?
				respond_to do |format|
					flash[:error] = errors.join(', ')
					format.html { render :new }
				end
			end
		end

		def lock_order
			if @order.status != 1
				respond_to do |format|
					flash[:error] = 'Order could not be updated.'

					format.html {redirect_to @order}
					format.json { head :no_content }
				end
			end
		end
end
