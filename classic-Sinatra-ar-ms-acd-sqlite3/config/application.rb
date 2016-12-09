# if ENV.fetch("RACK_ENV") == "development"
#   p "you're in #{__FILE__}"
# end


require File.expand_path('../boot', __FILE__)



configure do
  # Some helper constants for path-centric logic
  APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
  # By default, Sinatra assumes that the root is the file that calls the configure block.
  # Since this is not the case for us, we set it manually.
  set :root, APP_ROOT.to_path
  p APP_NAME = APP_ROOT.basename.to_s
  # config_file File.join( [APP_ROOT, 'config', 'config.yml'] )

  # # Set up the controllers, views, and helpers
  Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
  Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
  Dir[APP_ROOT.join('app', 'views', '*.rb')].each { |file| require file }

  # # not needed because we use the database.rb here in config land.
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each { |file| require file }
  # # Set up the database and models
  require APP_ROOT.join('config', 'database')
  # require APP_ROOT.join('config', 'application')  
  
  
  
  # #register Config

  # # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  # register do
  #   def auth(type)
  #     condition do
  #       unless send("current_#{type}")
  #         redirect '/login'
  #         add_error!("Not authorized, please login.")
  #       end
  #     end
  #   end
  # end 

  # use OmniAuth::Builder do
  #   provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  # end

end



