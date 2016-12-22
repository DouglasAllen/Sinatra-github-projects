ENV['RACK_ENV'] = 'test'

require "./spec/spec_helper"
require "./app"

describe "Basic Test" do
  include Rack::Test::Methods

  before(:all) do
    Item.delete_all
  end

  def app
    Sinatra::Application
  end

  # DB test
  it "item create" do
    @item = create(:item)
    @item.name.should == "item name"
  end

  # rendering test
  it "should render 'Hello World'" do
    get '/'
    last_response.include?("Hello World")
  end

  it "item list" do
    get '/list/item'
    last_response.include?("item name")
  end
end
