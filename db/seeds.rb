# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all


users = Array.new

10.times do |i|
  user = User.create(first_name: Faker::Name.name, last_name: Faker::Name.name, email: "usereventbrite#{i}@yopmail.com", encrypted_password: Faker::Lorem.word, description: "Voici une courte description au pif ahahah",  )
  users << user
end