class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
    	t.string :account_type
    	t.string :description
    	t.integer :amount
    	t.timestamps
    end
  end
end
