require 'sinatra'
require 'activerecord'
require 'haml'
require 'db_connect.rb'
require 'models.rb'




get '/stylesheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :stylesheet
end

get '/' do
  haml :index
end


helpers do

end


