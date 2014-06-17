class StoreController < ApplicationController

	#this will be our home/landing page
	#it will display all the products
	def index
		#we want to display the products that have a buyable quantity
		#(i.e., more than zero!), and display them in alphabetical order.
		@products = Product.where('quantity > 0').order(:name)

    if session[:cart].nil?
      session[:cart] = {}
    end
    @cart = session[:cart]

    @sum = Cart.sum_total(@cart)
	end

	def description
		#with this action we'll pull up a page similar to the product_show page.
		#you'll be passing a parameter to call up the specific product,
		#as seen below.
		@product = Product.find(params[:id])
	end

	def add_to_cart
		product_id = params[:product_id].to_i
  	quantity = params[:quantity].to_i
    @product_name = params[:product_name]
    price = params[:price].to_f

  	line_item = { product_id: product_id, quantity: quantity}
  	
  	if session[:cart].nil?
  		session[:cart] = {}
  	end

		current_cart = session[:cart]
  	
  	if current_cart[product_id].nil?
  		current_cart[product_id] = [quantity, @product_name, price]
  	else
  		value_array = current_cart[product_id]
      old_quantity = value_array[0]
      new_quantity = old_quantity + quantity
  		current_cart[product_id] = [new_quantity, @product_name, price]
      #the current_cart is a has, where the product_id is key, and an array, #which contains the quantity desired, the product name, and the price #per unit, is the value
  	end

  	@cart = current_cart

  	#Rails.logger.info "CART= #{session[:cart]}"

    @sum = Cart.sum_total(@cart)
	end

	def remove_from_cart
    product_id = params[:product_id].to_i
    @cart = session[:cart]
    @cart.delete(product_id)

    redirect_to store_index_path
	end
end