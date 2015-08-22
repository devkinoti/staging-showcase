class AddShopPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :shop_price, :integer
  end
end
