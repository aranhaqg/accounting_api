class Account < ApplicationRecord
	belongs_to :user
	validates_presence_of :user, :balance

	def credit(amount)
		self.balance +=amount
		save
	end

	def debit(amount)
		self.balance -=amount
		save
	end
end