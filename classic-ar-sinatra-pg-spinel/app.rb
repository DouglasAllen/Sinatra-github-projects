require 'sinatra'
require 'sinatra/activerecord'

# Helpers
require './helpers/app_helpers'
require './helpers/auth_helpers'

# Controllers
require './controllers/base_controller'
require './controllers/posts_controller'

# Models
require './models/post'

# Databases
configure :development do
  set :database, 'postgres://<username>:<password>@<host>:<port>/<database_name>'
end

configure :production do
  set :database, 'postgres://<username>:<password>@<host>:<port>/<database_name>'
end
