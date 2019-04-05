require 'test_helper'
class ConsultBalanceFeatureTest < ActiveSupport::TestCase
	def setup
		@user = User.new(email: 'aranhaqg@gmail.com', password: '123456')
		@user.save!
		@user2 = User.new(email: 'aranha2qg@gmail.com', password: '123456')
		@user2.save!
		@account = Account.new(user: @user, balance: 6)
		@account.save!
		@account2 = Account.new(user: @user2, balance: 6)
		@account2.save!

	end

	test "when account's balance is consulted, return the updated value of account with it's previous operations" do
		assert_equal @account.balance, 6
		assert_equal @account2.balance, 6
		Transaction.transfer(@account.id, @account2.id, 1)
		@account.reload
		@account2.reload
		assert_equal @account.balance, 5
		assert_equal @account2.balance, 7
	end
end
