# Simple Accounting  API [![Build Status](https://travis-ci.com/aranhaqg/accounting_api.svg?branch=master)](https://travis-ci.com/aranhaqg/accounting_api)

Rails REST API to manage bank accounts, allowing the user to get his account balance and transfer money to another account, always in Reais (R$).

The API is available at https://aranha-accounting-api.herokuapp.com/ via Heroku.

This app uses:

* Ruby version 2.5.1
* Rails 5.2.3
* PostgreSQL 9.6.8
* Devise
* Simple Token Authentication

To run tests it was used Minitest and Database Cleaner gems. For more details check [Gemfile](Gemfile).

To check the implemented tests see [Consult Balance Feature Test](/test/features/consult_balance_feature_tes.rb), [Transfer Money Feature Test](/test/features/transfer_money_feature_test.rb) and [Transactions Controller Test](/test/controllers/transactions_controller_test.rb)


## Entities And Classes
### User

The [User](/app/models/user.rb) entity it's a devise generated user model composed of the following properties:

	* email: String 
	* encrypted_password: String 
	* reset_password_token: String 
	* reset_password_sent_at: DateTime
	* remember_created_at: DateTime
	* created_at: DateTime 
	* updated_at: DateTime 
	* authentication_token: String

### Account

The [account](/app/models/account.rb) entity it's composed of the following properties:

    * user_id: Integer (reference to User model)
    * balance: Decimal
    * created_at: DateTime
    * updated_at: DateTime

This entity has a method to debit and credit amount used in transactions.

### Transaction

The [Transaction](/app/models/transaction.rb) entity it's a entity composed of the following properties:

    * balance: Decimal
    * source_account_id: Integer (reference to Account model)
    * destination_account_id: Integer (reference to Account model)
    * created_at: DateTime
    * updated_at: DateTime

This entity has a tranfer method to validate and create the transfer transaction.
If a future will be interesting add a state machine to make transfer and another transactions like payments for example.

### Account Types

The [Account Types](/app/models/report_handler.rb) is a simple class to hold account types like SOURCE and DESTINATION accounts in transactions.

### Account Not Found Error

The [Account Not Found Error](/app/models/exceptions/account_not_found_error.rb) is a simple class to hold execeptions when an account wasn't found.

### Not Enough Balance Error

The [Not Enough Balance Error](/app/models/exceptions/not_enough_balance_error.rb) is a simple class to hold execeptions when an account hos not enough money to perform a transaction.


## Endpoints
All defined endpoints returns a JSON Object (a message or requested entities).

### POST api/v1/sessions

This endpoint is used to login the user so the transactions can be done. 

To make a succesful login send in the url the params: email and password. If the password is right a JSON object with the email and authentication_token will be returned with a CREATED status (201). This token will be necessary to perform transaction and logout and should be added in the request header.
If the password is wrong,a UNAUTHORIZED status (401) will be returned.

### DELETE api/v1/sessions

This endpoint is used to logout the user from the api.

To logout properly the request header should contain the keys X-User-Email with the user email as value and X-User-Token with the token returned at login as value.
If the logout was succesful, a OK status (200) will be returned. If not, a UNAUTHORIZED status (401) will be returned.  

### GET /api/v1/transactions/balance

This endpoint is used to get the account balance and its handled by action balance at [Transactions Controller](/app/controllers/transactions_controller.rb). 
To get the balance the request header contain the keys X-User-Email with the user email as value and X-User-Token with the token returned at login as value and id (account id) with its value as url params.

If the request was succesful a JSON object if the balance and OK status (200) will be returned. If the account wasn't found a JSON object with the error message and a UNPROCESSABLE ENTITY status (422) will be returned. If the id params is missing a JSON object with the error message and a BAD REQUEST status (400) will be returned.

### POST api/v1/transactions/transfer

This endpoint is used to perform a transfer between accounts and its handled by action transfer at [Transactions Controller](/app/controllers/transactions_controller.rb). 
To make the transfer the request header contain the keys X-User-Email with the user email as value and X-User-Token with the token returned at login as value and source_account_id, destination_account_id and amount with its respective values as url params.

If the request was succesful a JSON object will be returned with a succes message and OK status (200) will be returned. If any params is missing, a JSON object with the error message and a BAD REQUEST status (400) will be returned. If the source or destination accounts wasn't found or there's not anough source account balance to make the transfer, a JSON object with the error message and a UNPROCESSABLE ENTITY status (422) will be returned. 


## Future Improvements

* Use ActiveModel Serializer to handle better serialization/deserialization.
* Implement token expiration.
* Improve security with Rack Attack to protect from bad clients. Can be used to prevent brute-force passwords attacks, scrapers and throttling requests from IP addresses for example.
* Scan code to look for security vulnerabilities with Brakeman. 
* Add payment and get bank statement features.
* Add State Machines to Transaction model (AASM gem).
* Add a Web UI to the app
