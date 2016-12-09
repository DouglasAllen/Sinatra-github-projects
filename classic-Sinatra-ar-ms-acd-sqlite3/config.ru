
require File.expand_path('../config/environment',  __FILE__)

use Rack::Static,
      :urls => ["/fonts", "/images", "/javascripts", "/stylesheets"],
      :root => "public/assets"

run Sinatra::Application