# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User and accounting setup to test in heroku
user = User.where(email: 'aranha@gmail.com').first_or_initialize
user.password = '123456' if user.new_record?
user.save!	

user2 = User.where(email: 'aranha2@gmail.com').first_or_initialize
user2.password = '123456' if user2.new_record?
user2.save!

source_account = Account.where(user: user, balance: 100).first_or_initialize
source_account.save!

destination_account = Account.where(user: user2, balance: 100).first_or_initialize
destination_account.save!