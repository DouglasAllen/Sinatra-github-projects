

module EOT
  class << self
  
    include Math    
  
    attr_accessor :ajd, :date, :jd, :latitude, :longitude, :data

    def initialize(latitude=nil, longitude=nil)

      @ajd          = nil      
      @date        = nil
      @jd           = nil
      @latitude     = latitude
      @longitude    = longitude
      @file_path     =  File.expand_path( File.dirname( __FILE__ ) + "/nutation_series2.yaml" )
      @data         = YAML::load( File.open( @file_path, 'r'), :safe => true )      

    end
  end
end
