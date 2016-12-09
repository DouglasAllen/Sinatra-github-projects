require 'sinatra'

get '/' do
  # html :index
  send_file 'index.html'
end
