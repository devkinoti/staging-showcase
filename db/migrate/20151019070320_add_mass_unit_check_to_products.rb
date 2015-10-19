class AddMassUnitCheckToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :mass_unit_check, :boolean
  end
end
