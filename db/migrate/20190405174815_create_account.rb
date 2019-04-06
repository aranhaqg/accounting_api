class CreateAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
    	t.references :user, foreign_key: true
    	t.decimal :balance, precision: 6, scale: 2

    	t.timestamps
    end
  end
end
