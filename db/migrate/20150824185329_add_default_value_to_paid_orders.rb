class AddDefaultValueToPaidOrders < ActiveRecord::Migration
  def up
  	change_column :orders,:paid,:boolean, :default => false
  end

  def down
  	change_column :orders,:paid,:boolean,:default => nil
  end
end
