class OrdersController < ApplicationController
  def index
  	@orders = Order.order('id desc')
  end
end
