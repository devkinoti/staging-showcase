class ChangeQuantityToDecimalInProducts < ActiveRecord::Migration
  def up
  	change_column :products, :quantity, :decimal, precision: 8, scale: 2
  end

  def down
  	change_column :products, :quantity, :integer
  end
end
