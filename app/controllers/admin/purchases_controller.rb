class Admin::PurchasesController < ApplicationController
	before_action :authorize_admin!
	layout "admin/admin"
	def show
		@search = ::Product.search(params[:q])
		@products = @search.result.all.paginate(:page => params[:page],:per_page => 10).order("created_at DESC")
	end
end