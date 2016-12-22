module EOT
  class << self

    def mean_anomaly_string(t = time_julian_century())
      degrees_to_s(mean_anomaly(t))
    end

    def true_anomaly_string(t = time_julian_century())
      degrees_to_s(true_anomaly(t))
    end

    def true_longitude_string(t = time_julian_century())
      degrees_to_s(true_longitude(t))
    end

    def apparent_longitude_string(t = time_julian_century())
      degrees_to_s(apparent_longitude(t))
    end

    def right_ascension_string(t = time_julian_century())
      degrees_to_s(right_ascension(t))
    end
  
    #~ def obliquity_correction_string(t = time_julian_century())
    #~ degrees_to_s(obliquity_correction(t))
    #~ end

    def true_obliquity_string(t = time_julian_century())
      degrees_to_s(true_obliquity(t))
    end

    def declination_string(t = time_julian_century())
      degrees_to_s(declination(t))
    end

    def degrees_to_s(degrees = 0)
      degrees.nil? ? degrees = 0 : degrees
      degrees < 0 ?
        sign_string = "-" :
        sign_string = "+"
      
      absolute_degrees = degrees.abs

      absolute_degrees_integer = Integer(absolute_degrees)
      absolute_decimal_minutes = 60.0 * (absolute_degrees - absolute_degrees_integer)
      absolute_minutes_integer = Integer(absolute_decimal_minutes)
      absolute_decimal_seconds = bd(60.0 * (absolute_decimal_minutes - absolute_minutes_integer))
      absolute_seconds_integer = Integer(absolute_decimal_seconds)
      absolute_milli_seconds_integer = Integer((absolute_decimal_seconds - absolute_seconds_integer) * 1000.0)

      sign_string +
        "%03d" % absolute_degrees_integer +
        ":" + "%02d" % absolute_minutes_integer +
        ":" + "%02d" % absolute_seconds_integer +
        "." + "%3.3d" % absolute_milli_seconds_integer
    end

    def time_to_s(time = 0)
      time.nil? ? time = 0 : time
      decimal = time % DAY_HOURS
      hours = Integer(decimal)
      mindecimal = bd(60.0 * (decimal - hours))
      minutes = Integer(mindecimal)
      seconds = bd(60.0 * (mindecimal - minutes))
      intsecs = Integer(seconds)
      decsecs = Integer((seconds - intsecs).round(3) * 1000.0)
      @date.nil? ? @date = Date.parse("#{Time.now.utc.year}-#{Time.now.utc.month}-#{Time.now.utc.day}") : @date
      
      time = (@date.to_time + time * 3600)
      
      "  " +
      "%02d" % time.hour +
      ":" +
      "%02d" % time.min +
      ":" +
      "%02d" % time.sec +
      "." +
      "%06d" % time.usec
    end

    def display_equation_of_time(dt = equation_of_time() )
      dt.nil? ? dt = equation_of_time() : dt
      #Equation of time output
      min_equation_of_time =  dt
      if min_equation_of_time < 0
        sign = "-"
      else
        sign = "+"
      end
      eot = min_equation_of_time.abs
      minutes = Integer(eot)
      seconds = (eot - minutes) * 60.0
      decimal_seconds = (seconds - Integer(seconds)) * 100.0
      sign << "%02d" % minutes << "m, " << "%02d" %  seconds << "." << "%02d" % decimal_seconds << "s"
    end
  
    def julian_period_day_fraction_to_time(jpd_time = 0)
      jpd_time.nil? ? jpd_time = 0 : jpd_time
      fraction = jpd_time + 0.5 - Integer(jpd_time)
      hours = Integer(fraction * DAY_HOURS)
      minutes = Integer((fraction - hours / DAY_HOURS) * DAY_MINUTES)
      seconds = Integer((fraction - hours / 24.0 - minutes / DAY_MINUTES) * DAY_SECONDS)
      "%02d" % hours +
        ":" +
        "%02d" % minutes +
        ":" +
        "%02d" % seconds
    end

    def show_minutes(min = 0)
      min.nil? ? min = 0 : min
      time = Time.utc(1, 1, 1, 0, 0, 0, 0.0)
      time = time + (min.abs * 60.0)
      if min < 0
        sign = "-"
      else
        sign = "+"
      end
      time.strftime("#{sign}%M:%S.%3N")
    end

    def show_now(now = now(Time.now.utc))
      show_minutes(now)
    end

  end
end