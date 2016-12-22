module EOT
  class << self

    def time_to_ajd(t = Time.utc(2000, 01, 01, 12, 00, 00, "+00:00"))
      t.nil? ? t = Time.utc(2000, 01, 01, 12, 00, 00, "+00:00") : t
      t == 0 ? t = Time.utc(2000, 01, 01, 12, 00, 00, "+00:00") : t
      time = t.to_a
      y = time[5]
      m = time[4]
      d = time[3]
      if m <= 2
        y -= 1
        m += 12
      end
      a = (y/100).floor
      b  = (a/4).floor
      c = 2-a+b
      e = (365.25  * (y + 4716)).floor
      f = (30.6001 * (m +1)).floor
      c + d + e + f - 1524.5
    end

    def jd_to_civil(jd = J2000)
      jd.nil? ? jd = J2000 : jd
      #~ if Date.valid_jd?(jd)
      a = jd
      #~ else
      x = ((jd - 1867216.25) / 36524.25).floor
      a = jd + 1 + x - (x / 4.0).floor
      #~ end
      b = a + 1524
      c = ((b - 122.1) / 365.25).floor
      d = (365.25 * c).floor
      e = ((b - d) / 30.6001).floor
      dom = b - d - (30.6001 * e).floor
      if e <= 13
        m = e - 1
        y = c - 4716
      else
        m = e - 13
        y = c - 4715
      end
      return y, m, dom
    end

    def jd_to_date_string(jd = J2000)
      jd.nil? ? jd = J2000 : jd
      Date.jd(jd).to_s
    end
  
    # this method is used for the ajd plus the time utc.
    # use ajd because time begins at midnight for the day.
    # use jd for mid day.
    def day_fraction_time(t = Time.utc(2000, 01, 01, 12, 00, 00, "+00:00"))
      t.nil? ? t = Time.utc(2000, 01, 01, 12, 00, 00, "+00:00") : t
      t == 0 ? t = Time.utc(2000, 01, 01, 12, 00, 00, "+00:00") : t
      time = t.to_a
      time[2] / DAY_HOURS  +
        time[1] / DAY_MINUTES +
        time[0] / DAY_SECONDS
      #~ t.usec / DAY_USECS
    end

    def ajd_time(t = Time.utc(2000, 01, 01, 12, 00, 00, "+00:00"))
      t.nil? ? t = Time.utc(2000, 01, 01, 12, 00, 00, "+00:00") : t
      # The AJD plus day_fraction_time
      # Used when we need the total of ajd and time to get  time_julian_centurey() 
		  #~ raise ArgumentError, "date attribute must not be nil" if @date.nil?
      day_fraction_time(t) + time_to_ajd(t)
      #~ Date.parse("#{t.year}-#{t.month}-#{t.day}").ajd * 1.0
    end
    
    # all calculations with (t)  based on this decimal Centurey
    def time_julian_century(t = Time.utc(2000, 01, 01, 12, 00, 00, "+00:00"))
      t.nil? ? t = Time.utc(2000, 01, 01, 12, 00, 00, "+00:00") : t
      Date.valid_jd?(t) ? jd = t : jd = ajd_time(t)      
      t.class == Time ? jd = ajd_time(t) : jd = t
      # Time in fractional centurey
      # Julian Day Number j(2000) subtracted
      t = (jd - J2000) / 36525.0
      t2 = t * t
      t3 = t * t2
      t4 = t * t3
      t5 = t * t4
      [ t, t2, t3, t4, t5 ]       
    end
  

    def delta_orbit(t = time_julian_century())
      #~ 3.9890483625677007 * (mean_anomaly(t) - true_anomaly(t)) / 60.0
      #~ factor = 4.0 * ( 1 - 100 / 35625.0)
      ratio = 4.0 * factor / 360.0
      ratio * (mean_anomaly(t) - true_anomaly(t))
    end

    def delta_oblique(t = time_julian_century())
      #~ 3.9890483625677007 * (true_longitude(t) - right_ascension(t)) / 60.0
      #~ factor = 4.0 * ( 1 - 100 / 35625.0)
      ratio = 4.0 * factor / 360.0
      ratio * (true_longitude(t) - right_ascension(t))
    end
    
    def equation_of_time(t = time_julian_century())
      #~ 3.9890483625677007 * (geometric_mean_longitude(t) - right_ascension(t)) / 60.0
      delta_orbit(t) + delta_oblique(t)
    end

    def sunrise_time(date = "2000-01-01")
      date.nil? ? date = "2000-01-01" : date
      date == 0 ? date = "2000-01-01" : date
      jd = Date.parse(date).jd
      t = time_julian_century(jd)
      @longitude.nil? ? @longitude = 0 : @longitude
      @latitude.nil? ? 	@latitude = 0 : @latitude
      lha = (horizon_angle(t) / 15.0) * 3600
      date = Date.parse(date)
      time = Time.new(date.year, date.month, date.day, 0, 0, 0, "+00:00").utc
      tlnoon = time + (12 - @longitude / 15.0) * 3600
      eot = equation_of_time(time_julian_century(ajd_time(tlnoon))) * 60
      @sunrise = tlnoon - lha - eot
      @sunrise
    end
  
    def sunset_time(date = "2000-01-01")
      date.nil? ? date = "2000-01-01" : date
      date == 0 ? date = "2000-01-01" : date
      jd = Date.parse(date).jd
      t = time_julian_century(jd)
      @longitude.nil? ? @longitude = 0 : @longitude
      @latitude.nil? ? 	@latitude = 0 : @latitude
      lha = (horizon_angle(t) / 15.0) * 3600
      date = Date.parse(date)
      time = Time.new(date.year, date.month, date.day, 0, 0, 0, "+00:00").utc
      tlnoon = time + (12 - @longitude / 15.0) * 3600
      eot = equation_of_time(time_julian_century(ajd_time(tlnoon))) * 60
      @sunset = tlnoon + lha - eot
      @sunset
    end

    def now(time = Time.now.utc)
      time.nil? ? time = Time.now.utc : time
      ajd_time = ajd_time(time)
      t = time_julian_century(ajd_time)
      equation_of_time(t)
    end

    def get_time(time = Time.utc(2000, 1, 1, 12, 0, 0))
      time.nil? ? time = Time.utc(2000, 1, 1, 12, 0, 0) : time
      @date.nil? ? @date = Date.parse("2000-01-01") : @date
      temp_time = Time.utc(@date.year, @date.month, @date.day, 0, 0, 0)
      time.class != Time ? temp_time + time * 3600 : time
    end
    
  end
end