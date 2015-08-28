class Admin::ExpensesController < ApplicationController
	before_action :authorize_admin!
	before_action :find_expense, :only => [:edit,:update,:destroy]
	layout "admin/admin"
	def index
		@expenses = Expense.all
	end

	def new
		@expense = Expense.new
	end

	def create
		@expense = Expense.new(expense_params)
		if @expense.save
			flash[:notice] = "Expense added to list"
			redirect_to admin_expenses_path
		else
			flash[:alert] = "Expense has not been added to list"
			render :action => "new"
		end
	end

	def edit
	end

	def update
		if @expense.update_attributes(expense_params)
			flash[:notice] = "Expense successfully updated"
			redirect_to admin_expenses_path
		else
			flash[:alert] = "Expenses has not been updated"
			render :action => "new"
		end
	end

	def destroy
		@expense.destroy
		redirect_to admin_expenses_path
	end

	private

	def expense_params
		params.require(:expense).permit(:amount,:account_type,:description)
	end

	def find_expense
		@expense = Expense.find(params[:id])
	end
end