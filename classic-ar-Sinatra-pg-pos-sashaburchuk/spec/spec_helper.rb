ENV['RACK_ENV'] = 'test'
require("rspec")
require("pg")
require("sinatra/activerecord")
require("items")
require("purchases")

RSpec.configure do |config|
  config.after(:each) do
    Item.all().each() do |item|
      item.destroy()
    end
  end
end
