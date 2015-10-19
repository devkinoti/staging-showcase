class Product < ActiveRecord::Base
	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	validates :name, presence: true

	validates :product_type, presence: true
	validates :units, presence: true
	validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0.01}
	validates :purchase_price, presence: true, numericality: { greater_than_or_equal_to: 0.01}
	validates :shop_price, presence: true, numericality: { greater_than_or_equal_to: 0.01}


	def total_price
		self.purchase_price * self.quantity
	end



	def remove_from_stock!(qty)
		self.quantity = self.quantity - qty
		save
	end

	def total_sold
		Array(self.line_items).sum do |item|
			item.quantity
		end
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
