class EnoughProductsValidator < ActiveModel::Validator 
	def validate(order)
		order.line_items.each do |item|
			product = item.product 
			if item.quantity > product.quantity
				order.errors["#{product.name}"] << "order cannot be completed.There are only #{product.quantity} items left in stock.Kindly restock the product or remove the product from the cart"
			end
		end
	end
end
