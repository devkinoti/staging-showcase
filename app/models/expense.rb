class Expense < ActiveRecord::Base
	validates :amount, numericality: { only_integer: true, message: "Please enter a number only" }
end
