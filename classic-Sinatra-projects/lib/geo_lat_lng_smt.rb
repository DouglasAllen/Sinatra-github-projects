# geo_lat_lng_smt.rb
#~ require 'uri'
require 'rest-client'
require 'crack'

class GeoLatLng

  attr_accessor :addr, :lat, :lng

  def initialize
    # Instance variables
    @base_google_url = "http://maps.googleapis.com/maps/api/geocode/xml?sensor=false&address="
    #~ @addr = addr
  end

  def addr=(addr)
    @addr = addr
  end  

  def get_coordinates_from_address
	  if @addr == nil
       @addr = "3333 Coyote Hill Road, Palo Alto, CA, 94304, USA"
       #~ @addr = "Amphitheatre, University of Tennessee, Knoxville, TN 37916, USA"
    end
    #~ res = URI.encode("#{@base_google_url}#{@addr}")    
    res = RestClient.get(URI.encode("#{@base_google_url}#{@addr}"))
    #~ puts res
    parsed_res = Crack::XML.parse(res)
    p parsed_res
    if parsed_res["GeocodeResponse"]["status"] != 'OK'
			@lat = 0.0
      @lng = 0.0
      @addr = "3333 Coyote Hill Road, Palo Alto, CA, 94304, USA"
    else
      @lat = parsed_res["GeocodeResponse"]["result"]["geometry"]["location"]["lat"]
      @lng = parsed_res["GeocodeResponse"]["result"]["geometry"]["location"]["lng"]
    end
    
  end

end