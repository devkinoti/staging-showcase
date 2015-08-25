class EnoughProductsValidator < ActiveModel::Validator 
	def validate(order)
		order.line_items.each do |item|
			product = item.product 
			if item.quantity > product.quantity
				order.errors["#{product.name}"] << "Is out of Stock,There are only #{product.quantity} items left in stock"
			end
		end
	end
end
