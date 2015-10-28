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

  def self.import(file)
  	attributes = %w{id product_id cart_id created_at updated_at quantity price order_id}
  	CSV.foreach(file.path, headers: true) do |row| 
  		line_item = find_by_id(row["id"]) || new 
  		line_item.attributes = row.to_hash.slice(*attributes)
  		line_item.save!
  	end
  end

end
