
class TransferMoneyFeatureTest < ActiveSupport::TestCase
	def setup
		@user = User.new(email: 'aranhaqg@gmail.com', password: '123456')
		@user.save!
		@user2 = User.new(email: 'aranha2qg@gmail.com', password: '123456')
		@user2.save!
		@source_account = Account.new(user: @user, balance: 6)
		@source_account.save!
		@destination_account = Account.new(user: @user2, balance: 6)
		@destination_account.save!
	end


	test 'when the accounts exists and user has enough balance transfer money from his account to the destination account' do 
		Transaction.transfer(@source_account.id, @destination_account.id, 1)
		@source_account.reload	
		@destination_account.reload
		assert_equal @source_account.balance, 5
		assert_equal @destination_account.balance, 7
	end

	test "when account exists and user don't have enough balance, don't cancel operatation and return the error" do
		exception = assert_raise Exceptions::NotEnoughBalanceError do
			Transaction.transfer(@source_account.id, @destination_account.id, 10)
		end
		assert_equal I18n.t('errors.not_enough_balance', account_id: @source_account.id), exception.message 
	end

	test "when any of the source account don't exist, return an error informing it" do 
		exception = assert_raise Exceptions::AccountNotFoundError do
			Transaction.transfer(100, @destination_account.id, 10)
		end
		assert_equal I18n.t('errors.source_account_not_found'), exception.message 
	end

	test "when any of the destination account don't exist, return an error informing it" do 
		exception = assert_raise Exceptions::AccountNotFoundError do
			Transaction.transfer(@source_account.id, 100, 10)
		end
		assert_equal I18n.t('errors.destination_account_not_found'), exception.message 
	end
end
