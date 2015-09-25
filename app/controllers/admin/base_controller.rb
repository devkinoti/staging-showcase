class Admin::BaseController < ApplicationController
	before_filter :authorize_admin!

	layout "admin/admin"

	def index
		@total_expenses = Expense.sum("amount")
		@orders = ::Order.all.where(:paid => true)
		@total_inventory = ::Product.sum("quantity * purchase_price")
		gon.expenses_account = Expense.all.pluck("account_type")
		gon.expenses_amount = Expense.all.pluck("amount")
		@total_income = Array(@orders).sum { |order| order.order_price }

		@profit = @total_income - @total_expenses

		gon.daily_income = []
		gon.daily_income_dates = []
		daily_orders = Order.total_grouped_by_day(1.weeks.ago)
		(1.weeks.ago.to_date..Date.today).map do |date|
			daily_income = Array(daily_orders[date]).sum { |order| order.order_price }
			gon.daily_income << daily_income
			gon.daily_income_dates << date
		end

		gon.monthly_profits = []
		gon.profit_loss_months = []
		monthly_orders = Order.total_grouped_by_month(3.months.ago)
	    monthly_expenses = Expense.total_grouped_by_month(3.months.ago)
	    (3.months.ago.beginning_of_month.to_date.month..Date.today.to_date.month).map do |month|
	    	monthly_liability = monthly_expenses[month] || 0
	    	monthly_income = Array(monthly_orders[month]).sum { |order| order.order_price }
	    	monthly_profits = monthly_income - monthly_liability
	    	gon.monthly_profits << monthly_profits
	    	gon.profit_loss_months << Date::MONTHNAMES[month]
	    end
		# 	monthly_income = Array(monthly_orders[month]).sum { |order| order.order_price }
		# 	monthly_liability = Array(monthly_expenses[month]).sum("amount")
		# 	monthly_profits = monthly_income - monthly_liability
		# 	gon.monthly_profits << monthly_profits
		# 	gon.months << month
		# end


	end

	def sales
		@orders = ::Order.all.paginate(:page => params[:page],:per_page => 10).order("created_at DESC").where(:paid => true)
		@total_orders = Array(@orders).sum { |order| order.order_price }
	end

	def purchases
		@products = ::Product.all.paginate(:page => params[:page],:per_page => 10).order("created_at DESC")
	end

end