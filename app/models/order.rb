class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	has_many :products, through: :line_items

	
	after_save :calculate_stock

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end
	end

	def calculate_stock
      self.line_items.each do |item|
        item.product.remove_from_stock!(item.quantity)
      end
    end
end
