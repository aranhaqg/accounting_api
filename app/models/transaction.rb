class Transaction < ApplicationRecord
	belongs_to :source_account, class_name: 'Account'
	belongs_to :destination_account, class_name: 'Account'
	validates_presence_of :source_account, :destination_account, :amount


	def self.transfer(source_account_id, destination_account_id, amount)
		source_account = Account.find source_account_id
		raise AccountNotFoundError.new(AccountTypes::SOURCE) if source_account.nil?
		
		destination_account = Account.find destination_account_id
		raise AccountNotFoundError.new(AccountTypes::DESTINATION) if destination_account.nil?
		
		raise NotEnoughBalanceError.new(source_account_id) if amount > source_account.balance

		Transaction.transaction do
			Transaction.new(source_account: source_account, destination_account: destination_account, amount: amount).save
			source_account.debit(amount)
			destination_account.credit(amount)
		end
	end

end