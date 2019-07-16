class OrdersController < ApplicationController
	load_and_authorize_resource

	before_action :set_order, only: [:show, :edit, :update, :destroy]
	before_action :lock_order, only: [:edit, :update, :destroy]

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
			if @order.update(order_params)
				format.html { redirect_to @order, notice: 'Order was successfully updated.' }
				format.json { render :show, status: :ok, location: @order }
			else
				format.html { render :edit }
				format.json { render json: @order.errors, status: :unprocessable_entity }
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
		# Use callbacks to share common setup or constraints between actions.
		def set_order
			@order = Order.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def order_params
			params.require(:order).permit(:order_code, :order_date, :status, :total, :discount, items_attributes: [:id,:product_id, :price,:qty,:total,:_destroy])
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
