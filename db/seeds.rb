# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user_bob = User.create!(
  :email => "me@you.com",
  :password => 'password',
  :password_confirmation => 'password',
  :first_name => 'Bob',
  :last_name => 'Demo'
)

user_susie = User.create!(
  :email => "you@me.com",
  :password => 'password',
  :password_confirmation => 'password',
  :first_name => 'Susie',
  :last_name => 'Demo'
)
