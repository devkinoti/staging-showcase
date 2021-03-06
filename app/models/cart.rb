class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		current_item = line_items.find_by(product_id: product_id)
		if current_item
			current_item.quantity += 1.0
		else
			current_item = line_items.build(product_id: product_id)
			current_item.price = current_item.product.shop_price
		end
		current_item
	end

	def add_mass_product(product_id,quantity)
		current_item = line_items.find_by(product_id: product_id)
		if current_item
			current_item.quantity += quantity
		else
			current_item = line_items.build(product_id: product_id,quantity: quantity)
			current_item.price = current_item.product.shop_price
		end
		current_item
	end

	def decrease(line_item_id)
		current_item = line_items.find(line_item_id)
		if current_item.quantity > 1.0
			current_item.quantity -= 1.0
		else
			current_item.destroy
		end
		current_item
	end

	def decrease_mass_product(line_item_id)
		current_item = line_items.find(line_item_id)
		if current_item.quantity > 0.01
			current_item.destroy
		end
		current_item
	end


	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end
end
