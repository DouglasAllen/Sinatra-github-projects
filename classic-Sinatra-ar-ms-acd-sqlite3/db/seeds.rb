require 'faker'
require ::File.expand_path('../migrate/001_create_users', __FILE__)

puts "You are now seeding the database users table."

# 6.times do
  #create users
  password = Faker::Internet.password 
  user = User.new(
    name: Faker::Name.name,
    username: Faker::Internet.user_name,
    avatar_url: Faker::Avatar.image,
    uid: Faker::Lorem.characters(7),
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password
  )
   
  user.save!  
# end    
users=User.all

puts "You have seeded the database users table."