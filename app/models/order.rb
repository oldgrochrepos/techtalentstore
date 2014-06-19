class Order < ActiveRecord::Base

	belongs_to :customer
	has_many :line_items

	#setting a constant as the sales tax
	CURRENT_SALES_TAX = 0.07
	#I'm using the sales tax rate of Fulton County (Atlanta),
	#feel free to change it up to reflect your area,
	#or think about how you could take a zip code from the customer
	#and search through a database of sales tax rates!

	def self.process_order(customer, current_cart)
		#no need to worry about instance variables in this method,
		#we're just here to return a value
		order = Order.new

		sub_total = Cart.sum_total(current_cart)
		#this was a method we created in the Cart model
		#we now have the sum of all the items (quantity * price) wanting to be purchased

		#we can now start assigning the attributes of our order
		order.customer_id = customer.id
		order.sub_total = sub_total
		order.sales_tax = sub_total * CURRENT_SALES_TAX
		order.grand_total = order.sub_total + order.sales_tax

		if order.save
			current_cart.each do |key, value|
				line_item = LineItem.new
				line_item.product_id = key
				line_item.order_id = order.id
				line_item.quantity = value[0]
				line_item.unit_price = value[2]
				line_item.line_item_total = line_item.quantity * line_item.unit_price
				if line_item.save
					#Here we're adjusting the quantity of our stock (in the database)
					product = Product.find(line_item.product_id)
					product.quantity -= line_item.quantity
					product.save
				end
			end
		end
		return order
	end
end
