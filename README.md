# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
=======
# accounting_api
This is a simple accounting api to transfer money and get the account balance


curl -d '{"source_account_id":"1", "destination_account_id":"2", "amount": "3"}' -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/transactions/transfer
