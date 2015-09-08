class AddCashPaidToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :cash_paid, :integer
  end
end
