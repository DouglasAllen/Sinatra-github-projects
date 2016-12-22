module EOT

  # Constants
  
      DAY_HOURS         = 24.0
      DAY_MINUTES       = 1440.0
      DAY_SECONDS       = 86400.0
      DAY_USECS         = 86400000000.0
      J2000             = 2451545.0

  class << self    

    # beginning for accessors and mutators
    def ajd= (ajd = nil)
      #setter
      @ajd = ajd
    end
  
    def get_ajd(ajd = nil)
      # getter
      @ajd
    end
  	
    def date= (date = "2000-01-01")
      #setter
      date.nil? ? date = "2000-01-01" : date
      date == 0 ? date = "2000-01-01" : date
      @date = Date.parse(date)
    end
  
    def get_date(date = "2000-01-01")
      # getter
      @date
    end
  
    def jd= (jd = nil)
      #setter
      @jd = jd
    end
  
    def get_jd(jd = nil)
      # getter
      @jd
    end
  
    def latitude= (latitude = nil)
      # setter
      @latitude = latitude
    end
  
    def get_latitude(latitude = nil)
      # getter
      @latitude
    end
  
    def longitude= (longitude = nil)
      # setter
      @longitude = longitude
    end
  
    def get_longitude(longitude = nil)
      # getter
      @longitude
    end
  
    def data(data = @data)
      #getter
      @data
    end

    def data= (data = @data)
      #setter
      data = @data
	  end

  end
end   	