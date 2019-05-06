class Transaction < ApplicationRecord
	belongs_to :source_account, class_name: 'Account'
	belongs_to :destination_account, class_name: 'Account'
	validates_presence_of :source_account, :destination_account, :amount


	def self.transfer(source_account_id, destination_account_id, amount)
		source_account = Account.where(id: source_account_id).first
		raise Exceptions::AccountNotFoundError.new(AccountTypes::SOURCE) if source_account.nil?
		
		destination_account = Account.where(id: destination_account_id).first
		raise Exceptions::AccountNotFoundError.new(AccountTypes::DESTINATION) if destination_account.nil?
		
		raise Exceptions::NotEnoughBalanceError.new(source_account_id) if amount > source_account.balance

		Transaction.transaction do
			source_account.debit(amount)
			destination_account.credit(amount)
			Transaction.new(source_account: source_account, 
							destination_account: destination_account, 
							amount: amount, 
							source_account_balance: source_account.balance,
							destination_account_balance: destination_account.balance).save
		end
	end

	def self.statements(account_id)
		statements = Transaction.where(source_account_id: account_id).or(Transaction.where(destination_account_id: account_id)).order(:created_at)
		
		statements.map do |s| 
			{
				source_account_id: s.source_account_id,
				destination_account_id: s.destination_account_id,
				amount: s.amount,
				balance: (account_id == s.source_account_id ? s.source_account_balance : s.destination_account_balance) 
			} 
		end
	end
end
