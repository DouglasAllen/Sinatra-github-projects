require "sinatra"
require "sinatra/activerecord"

# set the db name (will be created if the
# db does not already exist)
set :database, "sqlite3:example.sqlite3"
#set :database, {adapter: "sqlite3", database: "example.sqlite3"}

class User < ActiveRecord::Base
end


get "/" do
  @users = User.all
  erb :index
end

post "/users/create" do
  user = User.new name: params[:name], email: params[:email]
  user.save
  redirect "/"
end