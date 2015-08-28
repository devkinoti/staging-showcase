class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def total_price
  	product.shop_price * quantity
  end

  # def total
  # 	Array(product).sum { |item| item.total_price }
  # end

end
