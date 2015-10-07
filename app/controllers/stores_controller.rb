class StoresController < ApplicationController
	before_action :authenticate_user!
	include CurrentCart
	before_action :set_cart
	
	def show
		@search = Product.search(params[:q])
		@products = @search.result.all.paginate(:page => params[:page],:per_page => 12).order("created_at DESC")
	end
end