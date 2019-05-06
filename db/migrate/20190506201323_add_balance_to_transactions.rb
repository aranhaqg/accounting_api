class AddBalanceToTransactions < ActiveRecord::Migration[5.2]
  def change
  	add_column :transactions, :source_account_balance, :decimal, precision: 6, scale: 2
  	add_column :transactions, :destination_account_balance, :decimal, precision: 6, scale: 2
  end
end
