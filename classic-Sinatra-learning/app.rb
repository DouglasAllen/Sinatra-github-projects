require 'bundler/setup'
require 'sinatra'
require 'json'

configure do
  # logging is enabled by default in classic style applications,
  # so `enable :logging` is not needed
  file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  file.sync = true
  use Rack::CommonLogger, file
end

use Rack::Auth::Basic, "Protected Area" do |username, password|
  username == 'foo' && password == 'bar'
end

get '/' do
  "Yay! You logged in okay. Now try /sinatra and /sub or /env"
end

get '/sinatra' do
  "Sinatra constants: #{Sinatra.constants.sort}</br></br>
   Sinatra methods: #{Sinatra.methods(false).sort}</br></br> 
   Sinatra instance methods: #{Sinatra.public_instance_methods(false).sort}</br></br>  
   # Include the helper modules provided in Sinatra's request context.</br>
   * see http://www.sinatrarb.com/intro.html#Helpers</br></br>
   # Create a new Sinatra application; the block is evaluated in the class scope.</br>
   * see http://hackersome.com/p/krekoten/sinatra :-)</br></br>
   # Extend the top-level DSL with the modules provided.</br>
   * see http://www.sinatrarb.com/extensions.html</br></br>   
   # Use the middleware for classic applications.</br>
    * see http://recipes.sinatrarb.com/p/middleware</br></br>"
end

get '/sub' do
  "Sinatra::Application constants: #{Sinatra::Application.constants.sort}</br></br> 
   Sinatra::Application methods: #{Sinatra::Application.methods(false).sort}</br></br>
   Sinatra::Application instance methods: #{Sinatra::Application.public_instance_methods(false).sort}</br></br>
   Sinatra::Base constants: #{Sinatra::Base.constants.sort}</br></br>
   Sinatra::Base methods: #{Sinatra::Base.methods(false).sort}</br></br>
   Sinatra::Base instance methods: #{Sinatra::Base.public_instance_methods(false).sort}</br></br>
   Sinatra::CommonLogger constants: #{Sinatra::CommonLogger.constants.sort}</br></br>
   Sinatra::CommonLogger methods: #{Sinatra::CommonLogger.methods(false).sort}</br></br>
   Sinatra::CommonLogger instance methods: #{Sinatra::CommonLogger.public_instance_methods(false).sort}</br></br>
   Sinatra::Delegator constants: #{Sinatra::Delegator.constants.sort}</br></br>
   Sinatra::Delegator methods: #{Sinatra::Delegator.methods(false).sort}</br></br>
   Sinatra::Delegator instance methods: #{Sinatra::Delegator.public_instance_methods(false).sort}</br></br>
   Sinatra::ExtendedRack constants: #{Sinatra::ExtendedRack.constants.sort}</br></br>
   Sinatra::ExtendedRack methods: #{Sinatra::ExtendedRack.methods(false).sort}</br></br>
   Sinatra::ExtendedRack instance methods: #{Sinatra::ExtendedRack.public_instance_methods(false).sort}</br></br>
   Sinatra::Helpers constants: #{Sinatra::Helpers.constants.sort}</br></br>
   Sinatra::Helpers methods: #{Sinatra::Helpers.methods(false).sort}</br></br>
   Sinatra::Helpers instance methods: #{Sinatra::Helpers.public_instance_methods(false).sort}</br></br>
   Sinatra::NotFound constants: #{Sinatra::NotFound.constants.sort}</br></br>
   Sinatra::NotFound methods: #{Sinatra::NotFound.methods(false).sort}</br></br>
   Sinatra::NotFound instance methods: #{Sinatra::NotFound.public_instance_methods(false).sort}</br></br>
   Sinatra::Request constants: #{Sinatra::Request.constants.sort}</br></br>
   Sinatra::Request methods: #{Sinatra::Request.methods(false).sort}</br></br>
   Sinatra::Request instance methods: #{Sinatra::Request.public_instance_methods(false).sort}</br></br>
   Sinatra::Response constants: #{Sinatra::Response.constants.sort}</br></br>
   Sinatra::Response methods: #{Sinatra::Response.methods(false).sort}</br></br>
   Sinatra::Response instance methods: #{Sinatra::Response.public_instance_methods(false).sort}</br></br>
   Sinatra::ShowException constants: #{Sinatra::ShowExceptions.constants.sort}</br></br>
   Sinatra::ShowException methods: #{Sinatra::ShowExceptions.methods(false).sort}</br></br>
   Sinatra::ShowException instance methods: #{Sinatra::ShowExceptions.public_instance_methods(false).sort}</br></br>
   Sinatra::Templates constants: #{Sinatra::Templates.constants.sort}</br></br>
   Sinatra::Templates methods: #{Sinatra::Templates.methods(false).sort}</br></br>
   Sinatra::Templates instance methods: #{Sinatra::Templates.public_instance_methods(false).sort}</br></br>
   Sinatra::VERSION #{Sinatra::VERSION}</br></br>
   Sinatra::Wrapper constants: #{Sinatra::Wrapper.constants.sort}</br></br>
   Sinatra::Wrapper methods: #{Sinatra::Wrapper.methods(false).sort}</br></br>
   Sinatra::Wrapper instance methods: #{Sinatra::Wrapper.public_instance_methods(false).sort}"
end



get '/env' do
  request.env.to_s  
end
