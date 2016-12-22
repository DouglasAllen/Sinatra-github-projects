module EOT
  class << self

    def mean_anomaly(t = time_julian_century())
      t.nil? ? t = time_julian_century() : t
      # Horners method
      #~ bd(truncate(357.529109181 + 
      #~ 35640.0 * t +
      #~ t * (359.050291139 -
      #~ t * (0.000153666666667 -
      #~ t * (3.77777777778e-08 -
      #~ t * 3.19166666667e-09)))))
      truncate(357.529109181 +
          t[0]	* 35999.050291139 -
          t[1] * 0.000153666666667 +
          t[2] * 3.77777777778e-08 -
          t[3] * 3.19166666667e-09)
    end
    
    def equation_of_center(t = time_julian_century())
      t.nil? ? t = time_julian_century() : t
      mean_anomaly = mean_anomaly(t)
      sine_mean_anomaly = sin(degrees_to_radians(mean_anomaly))
      sine_2mean_anomaly = sin(2.0 * degrees_to_radians(mean_anomaly))
      sine_3mean_anomaly = sin(3.0 * degrees_to_radians(mean_anomaly))
      sine_mean_anomaly * (1.914602 - t[0] * (0.004817 + 0.000014 * t[0])) +
        sine_2mean_anomaly * (0.019993 - 0.000101 * t[0]) +
        sine_3mean_anomaly * 0.000289
    end
        
    def true_anomaly(t = time_julian_century())
      mean_anomaly(t) + equation_of_center(t)
    end

    def geometric_mean_longitude(t = time_julian_century())
      t.nil? ? t = time_julian_century() : t
      #Mean longitude of the sun
      # Horners method    
      #~ bd(truncate(280.4664567 + 
      #~ t * (36000.76982779 +
      #~ t * (0.0003032028 +
      #~ t * (2.00276381406e-05 -
      #~ t * (6.53637492647e-05 +
      #~ t * 5.03018108652e-07))))))
      truncate(280.4664567 +
          t[0] * 36000.76982779 +
          t[1] * 0.0003032028 +
          t[2] / 49931.0 -
          t[3] / 15299.0 -
          t[4] / 1988000.0)
    end

    def true_longitude(t = time_julian_century())
      truncate(geometric_mean_longitude(t) + equation_of_center(t))# - 0.01397 * (Time.now.year - 2000.0)) * 1.0
    end
  
    def sine_true_longitude(t = time_julian_century())
      sin(degrees_to_radians(true_longitude(t)))
    end

    def cosine_true_longitude(t = time_julian_century())
      cos(degrees_to_radians(true_longitude(t)))
    end
  
    def omega(t = time_julian_century())
      t.nil? ? t = time_julian_century() : t
      # Horners method for polynomials
      #~ bd(truncate(125.04455501 -
      #~ 1800.0 * t -
      #~ t * (134.136261972 -
      #~ t * (0.00207561111111 +
      #~ t * (2.13944444444e-06 -
      #~ t * 1.64972222222e-08)))))
      truncate(125.04455501 -
          t[0] * 1800.0  -
          t[0] * 134.136261972 +
          t[1] / 481.7858 +
          t[2] / 467411.062 -
          t[3] / 60616265.365)
    end
  
    def apparent_longitude(t = time_julian_century())
      # APPARENT SOLAR LONGITUDE = GEOMETRIC MEAN LONGITUDE PLUS
      # EQUATION OF THE CENTER MINUS 
      # ABERRATION       
      true_longitude(t) - 0.00569 - 0.00478 * sin(degrees_to_radians(omega(t)))
    end
  
    def sine_apparent_longitude(t = time_julian_century())
      sin(degrees_to_radians(apparent_longitude(t)))
    end

    def cosine_apparent_longitude(t = time_julian_century())
      cos(degrees_to_radians(apparent_longitude(t)))
    end
  
    def eccentricity_earth_orbit(t = time_julian_century())#unitless
      t.nil? ? t = time_julian_century() : t
      # Horners method
      0.016708617 -
        t[0] * (0.000042037 +
          t[0] * 0.0000001235)
    end
  
    def mean_obliquity(t = time_julian_century())
      t.nil? ? t = time_julian_century() : t
      23.43927944 -
        t[0] / 76.863 -
        t[1] * 5.086e-8 +
        t[2] * 0.0000005565 +
        t[3] * 0.00000000016 -
        t[4] * 9.444e-13
    end
  
    def delta_epsilon(t = time_julian_century())
      #~ 0.00256 * cos(degrees_to_radians(omega(t)))
      delta_equinox(t)[0]
    end
  
    #~ def obliquity_correction(t = time_julian_century())
    #~ mean_obliquity_of_ecliptic(t) + delta_epsilon(t)
    #~ end

    def true_obliquity(t = time_julian_century())
      mean_obliquity(t) + delta_epsilon(t)# / ARCSEC
    end

    def cosine_true_obliquity(t = time_julian_century())
      cos(degrees_to_radians(true_obliquity(t)))
    end
  
    def right_ascension(t = time_julian_century())
      y0 =  cosine_true_obliquity(t) * sine_true_longitude(t)
      radians_to_degrees(atan2(-y0, -cosine_true_longitude(t))) + 180.0
    end
      
    def declination(t = time_julian_century())
      sine_declination = sin(degrees_to_radians(true_obliquity(t))) * sine_apparent_longitude(t)
      radians_to_degrees(asin(sine_declination))
    end
    
    def horizon_angle(t = time_julian_century())
      zenith = 90.8333
      cosine_zenith = cos(degrees_to_radians(zenith))
      cosine_declination = cos(degrees_to_radians(declination(t)))
      sine_declination = sin(degrees_to_radians(declination(t)))
      @latitude.nil? ? latitude = 0 : latitude = @latitude
      cosine_latitude = cos(degrees_to_radians(latitude))
      sine_latitude = sin(degrees_to_radians(latitude))
      tangent_altitude = cosine_zenith / cosine_declination * cosine_latitude
      tangent_declination = sine_declination / cosine_declination
      tangent_latitude = sine_latitude / cosine_latitude
      top = cosine_zenith - sine_declination * sine_latitude
      bottom = cosine_declination * cosine_latitude
      radians_to_degrees(acos(bd(top / bottom)))
    end
        
    def mean_longitude_aries(t = time_julian_century())
      t.nil? ? t = time_julian_century() : t
      # Mean equinox point where right ascension is measured from as zero hours.
      # Horners method
      truncate(280.46061837 +
          t[0] * 36525.0 * 360.98564736629 +
          t[0] * (t[0] * 0.000387933 -
            t[0] * (t[0] / 38710000.0)))
    end
  
    def delta_psi(t = time_julian_century())
      t.nil? ? t = time_julian_century() : t
      delta_equinox(t)[1]
    end

    def eq_of_equinox(t = time_julian_century())
      t.nil? ? t = time_julian_century() : t
      delta_psi(t) * Math::cos(Math::PI / 180 * true_obliquity(t))
    end

    def true_longitude_aries(t = time_julian_century())
      t.nil? ? t = time_julian_century() : t
      eq_of_equinox(t) + mean_longitude_aries(t)
    end

    def factor
      jda = Date.parse("2000-01-01").jd
      jdb = Date.parse("2000-01-02").jd
      tjca = time_julian_century(jda)
      tjcb = time_julian_century(jdb)
      tlaa = true_longitude_aries(tjca)
      tlab = true_longitude_aries(tjcb)
      dif = tlab - tlaa
      dr = dif + 360.0
    end

  end
end