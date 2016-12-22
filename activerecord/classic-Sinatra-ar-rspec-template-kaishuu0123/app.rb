require 'sinatra'
require 'bundler/setup'
require 'sinatra/activerecord'
require 'logger'
require 'sinatra/reloader' if development?

RACK_ENV ||= (ENV["RACK_ENV"] || "development")
Dir[File.dirname(__FILE__)+"/models/*.rb"].each { |file| require file }
Dir.mkdir('log') if !File.exists?('log') || !File.directory?('log')
ActiveRecord::Base.logger = Logger.new(File.open("log/#{RACK_ENV}.log", "a+"))

configure do
  # set :bind, "0.0.0.0"
  # set :port, 5678
  set :views, "#{File.dirname(__FILE__)}/views"
end

before do
  ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
  ActiveRecord::Base.establish_connection(RACK_ENV.to_sym)
end

get '/' do
  erb :index
end

get '/list/item' do
  @items = Item.all
  erb :list_item
end

get '/create/item' do
  @item = Item.new
  @item.name = "hoge"
  @item.description = "example data"
  @item.save
  erb :create_item
end

get '/destroy/item' do
  item = Item.last
  if item
    @id = item.id 
    item.destroy
  end

  erb :destroy_item
end

after do
  ActiveRecord::Base.connection.close
end
