class AddPriceToLineItem < ActiveRecord::Migration
  def change
  	add_column :line_items, :price, :integer
  	LineItem.all.each do |li|
  		li.price = li.product.shop_price
  	end
  end
end
