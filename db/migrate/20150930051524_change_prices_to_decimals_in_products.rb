class ChangePricesToDecimalsInProducts < ActiveRecord::Migration
  def up
  	change_column :products, :purchase_price, :decimal, precision: 8, scale: 2
  	change_column :products, :shop_price, :decimal, precision: 8, scale: 2
  end

  def down
  	change_column :products, :purchase_price, :integer
  	change_column :products, :shop_price, :integer
  end
end
