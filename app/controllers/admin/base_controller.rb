class Admin::BaseController < ApplicationController
	before_filter :authorize_admin!

	layout "admin/admin"

	def index
		@total_expenses = Expense.sum("amount")
		@orders = ::Order.all

		@total_income = Array(@orders).sum { |order| order.order_price }

		@profit = @total_income - @total_expenses
	end


end