# test.rb
require_relative 'geo_lat_lng_smt'

obj = GeoLatLng.new
#~ obj.addr = "1600 Amphitheatre Parkway, Mountain View, CA"
obj.get_coordinates_from_address
puts obj.lat
puts obj.lng
