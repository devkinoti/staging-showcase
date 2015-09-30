class ChangeCashPaidToDecimalsInOrders < ActiveRecord::Migration
  def up
  	change_column :orders, :cash_paid, :decimal, precision: 8, scale: 2
  end

  def down
  	change_column :orders, :cash_paid, :integer
  end
end
