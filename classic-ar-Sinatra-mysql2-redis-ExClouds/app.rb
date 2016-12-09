require 'bundler/setup'
Bundler.require(:default)
require 'sinatra'
require 'sinatra/activerecord' # https://github.com/janko-m/sinatra-activerecord

folders = %w(
  lib
  config/initializers
  services
  models
  jobs
)

folders.each do |folder|
  Dir[folder + '/**/*.rb'].each { |file| require_relative file }
end

# set :database, {adapter: 'sqlite3', database: 'db_name.sqlite3'}
set :database_file, 'config/database.yml'

class App
  def self.start
    p 'START'
    Resque.enqueue(TestJob)
  end
end

# routes here
get '/' do
  p 'ROUTES WORK'
end

get '/erb' do
  erb :test
end
