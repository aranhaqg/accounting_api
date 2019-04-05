class CreateTransaction < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
    	t.decimal :amount, precision: 6, scale: 2
    	t.references :source_account, foreign_key: { to_table: :accounts}
    	t.references :destination_account, foreign_key: { to_table: :accounts}
    	
    	t.timestamps
    end
  end
end
