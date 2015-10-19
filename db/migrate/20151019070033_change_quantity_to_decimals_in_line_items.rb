class ChangeQuantityToDecimalsInLineItems < ActiveRecord::Migration
  def up
  	change_column :line_items, :quantity, :decimal, precision: 8, scale: 2
  end

  def down
  	change_column :line_items, :quantity, :integer, default: 1 
  end
end
