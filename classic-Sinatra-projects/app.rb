# app.rb
require 'haml'
require 'sinatra'
#~ require 'sinatra/base'

require_relative 'lib/equation_of_time'
require_relative 'lib/geo_lat_lng_smt'
require_relative 'analemma_data_table'

include EOT
include AnalemmaDataTable 
adt = AnalemmaDataTable
adt.initialize


configure do
  Sinatra::Application.reset!
  use Rack::Reloader
end

before do   
   
  @solar = EOT
  #~ @solar.initialize
  @universal_time = Time.now.utc 
  @year = @universal_time.year.to_s 
  @month = @universal_time.month.to_s 
  @day = @universal_time.day.to_s 
  @date_string = @year << "-" << @month << "-" << @day 
  @solar.date = @date_string 
  @solar.jd = @solar.date.jd
  @solar.ajd = @solar.date.ajd
	@geo = GeoLatLng.new
  
end

get "/analemma" do  
  @html = adt.get_html
	haml :analemma
end

get "/" do
	haml :index
end

get "/eot" do	
	haml :eot
end

get "/date" do	
	haml :date
end

get "/time" do	
	haml :time
end

get "/mean" do	
	haml :mean
end

get "/eqc" do	
	haml :eqc
end

get "/ecliplong" do	
	haml :ecliplong
end

get "/rghtascn" do	
	haml :rghtascn
end

get "/links" do	
	haml :links
end

get "/mysuntimes" do

  #~ p params[:address] 
  #~ @geo.addr = params[:address].to_s 
  #~ @geo.get_coordinates_from_address
  #~ @latitude = @geo.lat.to_f
	#~ @longitude = @geo.lng.to_f
	#~ @solar.latitude = @latitude
	#~ @solar.longitude =  @longitude		
	haml :mysuntimes

end

post "/mysuntimes" do

  p params[:address] 
  @geo.addr = params[:address].to_s 
  @geo.get_coordinates_from_address
  @latitude = @geo.lat.to_f
	@longitude = @geo.lng.to_f
	@solar.latitude = @latitude
	@solar.longitude =  @longitude		
	haml :mysuntimes

end

get "/suntimes" do
  haml :suntimes
end

get "/hello" do
  haml :hello
end

get "/julian" do
  haml :julian
end

get "/solar" do
  haml :solar
end

get "/final" do
  haml :final
end

get "/factor" do
  haml :star_time
end




