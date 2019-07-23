class ProductsController < ApplicationController
	load_and_authorize_resource
	before_action :set_product, only: [:show, :edit, :update, :destroy]
	before_action :set_status
	before_action :current_menu

	# GET /products
	# GET /products.json
	def index
		@products = Product.all
	end


	# GET /products/1
	# GET /products/1.json
	def show
	end

	# GET /products/new
	def new
		@product = Product.new
		@current_sub_menu = 'new_product'
	end

	# GET /products/1/edit
	def edit
	end

	# POST /products
	# POST /products.json
	def create
		@product = Product.new(product_params)
		@product.user_id = current_user.id

		respond_to do |format|
			if @product.save
				format.html { redirect_to products_url, notice: 'Product was successfully created.' }
				format.json { render :show, status: :created, location: @product }
			else
				format.html { render :new }
				format.json { render json: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /products/1
	# PATCH/PUT /products/1.json
	def update
		respond_to do |format|
			if @product.update(product_params)
				format.html { redirect_to products_url, notice: 'Product was successfully updated.' }
				format.json { render :show, status: :ok, location: @product }
			else
				format.html { render :edit }
				format.json { render json: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /products/1
	# DELETE /products/1.json
	def destroy
		respond_to do |format|
			if @product.can_destroy then
				@product.destroy
		
				flash[:notice] = 'Product was successfully destroyed.'
			else
				flash[:error] = 'Product could not be destroyed.'
			end

			format.html { redirect_to products_url }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_product
			@product = Product.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def product_params
			params[:product][:slug] = params[:product][:name].parameterize
			params.require(:product).permit(:sku, :name, :slug, :price, :stock, :description, :status)
		end

		def set_status
			@status = [['Active', 1], ['Inactive', 2]]
		end

		def current_menu
			@current_menu = 'products'
			@current_sub_menu = ''
		end
end
