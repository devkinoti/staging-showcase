class AlterProductsTable < ActiveRecord::Migration
  def change
  	add_column :products, :product_type, :string
  	add_column :products, :units, :string
  	add_column :products, :quantity, :integer
  	add_column :products, :purchase_price, :integer
  end
end
