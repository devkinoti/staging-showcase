class Admin::BaseController < ApplicationController
	before_filter :authorize_admin!

	layout "admin/admin"

	def index
		@total_expenses = Expense.sum("amount")
		@orders = ::Order.all.where(:paid => true)

		@total_income = Array(@orders).sum { |order| order.order_price }

		@profit = @total_income - @total_expenses
	end

	def sales
		@orders = ::Order.all.where(:paid => true)
		@total_orders = Array(@orders).sum { |order| order.order_price }
	end


end