class StoresController < ApplicationController
	before_action :authenticate_user!
	include CurrentCart
	before_action :set_cart
	
	def show
		@products = Product.order("created_at DESC")
	end
end