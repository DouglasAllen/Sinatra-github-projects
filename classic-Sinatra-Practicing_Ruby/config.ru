require 'rack/source'
require 'sinatra'
require_relative 'apps_here/app'

app = Rack::Builder.new do
  use Rack::Reloader
  use Rack::CommonLogger
  use Rack::ShowExceptions
  use Rack::Static,
      :urls => ["/fonts", "/images", "/javascripts", "/stylesheets"],
      :root => "/public"
	
  map '/run' do
    run Rack::Source.new('./run.rb')
  end
	
  map '/' do
    run App
  end	

end

run app
#options = {server: 'webrick', Port: 9393, Host: '0.0.0.0',  app: app}
#Rack::Server.start options
