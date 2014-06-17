class Customer < ActiveRecord::Base

	has_one :order
	#to compliment 'belongs_to :customer' in order.rb

	#we're going to through in some validation, so the user must enter all
	#their info. How else are we gonna ship they whatchamacalits?!
	validates_presence_of :name
	validates_presence_of :phone
	validates_presence_of :email, uniqueness: true
	validates_presence_of :address1
	validates_presence_of :city
	validates_presence_of :state
	validates_presence_of :zip

end
