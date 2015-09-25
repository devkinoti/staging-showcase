class Expense < ActiveRecord::Base
	validates :amount, numericality: { only_integer: true, message: "Please enter a number only" }

	def self.total_grouped_by_day(start)
    	expenses = where(created_at: start.beginning_of_day..Time.zone.now).group("created_at")
    	expenses.group_by { |expense| expense.created_at.to_date }
    end

    def self.total_grouped_by_month(start)
    	expenses = where(created_at: start.beginning_of_month..Time.zone.now).group("created_at")
    	monthly_expenses = expenses.group_by { |t| t.created_at.to_date.month }.map do |month,expenses|
    		[month,expenses.sum(&:amount)]
    	end.to_h
    end
end



# expenses = Expense.where(created_at: start.beginning_of_month..Time.zone.now).group("created_at")

# monthly_expenses = expenses.group_by { |t| t.created_at.to_date.month}.map do | month,expenses|
# 	[month,expenses.sum(&:amount)]
# end.to_h