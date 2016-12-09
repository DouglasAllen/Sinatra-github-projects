require 'app.rb'

log = File.new("sinatra.log", "w+")
STDOUT.reopen(log)
STDERR.reopen(log)

run Sinatra::Application
