class Admin::BaseController < ApplicationController
	before_filter :authorize_admin!

	layout "admin/admin"

	def index
		@total_expenses = Expense.sum("amount")
		@orders = ::Order.all.where(:paid => true)
		@total_inventory = ::Product.sum("quantity * purchase_price")

		@total_income = Array(@orders).sum { |order| order.order_price }

		@profit = @total_income - @total_expenses
	end

	def sales
		@orders = ::Order.all.paginate(:page => params[:page],:per_page => 10).order("created_at DESC").where(:paid => true)
		@total_orders = Array(@orders).sum { |order| order.order_price }
	end

	def purchases
		@products = ::Product.all.paginate(:page => params[:page],:per_page => 10).order("created_at DESC")
	end

end