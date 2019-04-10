require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@user = User.new(email: 'aranhaqg@gmail.com', password: '123456')
  	@user.save!	
  	@user2 = User.new(email: 'aranha2qg@gmail.com', password: '123456')
  	@user2.save!
  	@source_account = Account.new(user: @user, balance: 6)
  	@source_account.save!
  	@destination_account = Account.new(user: @user2, balance: 6)
  	@destination_account.save!
  	@user.reload
  end

	test "should return success if the transfer was successful" do
	 	post	api_v1_transactions_transfer_url,
					params: {source_account_id: @source_account.id, destination_account_id: @destination_account.id, amount: 3},
					headers: {"X-User-Email": @user.email, "X-User-Token": @user.authentication_token }
	 	assert_response :success
	end
	
	test "should return bad_request if any params is missing to transfer money" do
	 post api_v1_transactions_transfer_url,
	 			params: { destination_account_id: @destination_account.id, amount: 3 },
	 			headers: {"X-User-Email": @user.email, "X-User-Token": @user.authentication_token }
	 assert_response :bad_request
	end
	test "should return unprocessable_entity if source_account was not found to transfer money" do
	 post api_v1_transactions_transfer_url,
	 			params: { source_account_id: 100, destination_account_id: @destination_account.id, amount: 3 },
	 			headers: {"X-User-Email": @user.email, "X-User-Token": @user.authentication_token }
	 assert_response :unprocessable_entity
	end
	
	test "should return unprocessable_entity if destination_account was not found to transfer money" do
	  post 	api_v1_transactions_transfer_url,
	  			params: { source_account_id: @source_account.id, destination_account_id: 100, amount: 3 },
	  			headers: {"X-User-Email": @user.email, "X-User-Token": @user.authentication_token }
	  assert_response :unprocessable_entity
	end
	
	test "when consulting the balance should return success if the account was found" do
	  get api_v1_transactions_balance_url,
	  		params: {id: @source_account.id},
	  		headers: {"X-User-Email": @user.email, "X-User-Token": @user.authentication_token }
	  assert_response :success
	end
	
	test "when consulting the balance should return unprocessable_entity if account was not found" do
	  get api_v1_transactions_balance_url,
	  		params: { id: 100},
	  		headers: {"X-User-Email": @user.email, "X-User-Token": @user.authentication_token }
	  assert_response :unprocessable_entity
	end
	
	test "when consulting the balance should return bad_request if id parameter is missing" do
		get api_v1_transactions_balance_url,
				params: { },
				headers: {"X-User-Email": @user.email, "X-User-Token": @user.authentication_token }
		assert_response :bad_request
	end
end
