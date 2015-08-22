class Product < ActiveRecord::Base
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item
	validates :name, presence: true

	validates :product_type, presence: true
	validates :units, presence: true
	validates :quantity, presence: true
	validates :purchase_price, presence: true

	def total_price
		self.purchase_price * self.quantity
	end

	def total_expense
	end

	private

	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base,'Line Items present')
			return false
		end
	end



end
