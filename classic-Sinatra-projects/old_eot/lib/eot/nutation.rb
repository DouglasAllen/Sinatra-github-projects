module EOT
  class << self

    # Arc seconds to radians formula
    ARCSEC = 3600.0
    DTR = Math::PI / 180.0 / ARCSEC # adjusted for working in the arc seconds values
    RTD = 180.0 / Math::PI * ARCSEC # adjusted for working in the arc seconds values

    # sine degrees
    def sind(x = 0)
      x.nil? ? x = 0 : x
      Math::sin(DTR * x)
    end

    # cosine degrees
    def cosd(x = 0)
      x.nil? ? x = 0 : x
      Math::cos(DTR * x)
    end

    # convert arc seconds to degree
    def to_deg(arc_secs = 0)
      arc_secs.nil? ? arc_secs = 0 : arc_secs
      arc_secs / ARCSEC
    end

    # The JD is at Noon 12:00 UTC for today
    # In all of these expressions, T is the number of Julian centuries of TDB since 2000 Jan 1, 12h TDB (or,
    # with negligible error, the number of Julian centuries of TT since J2000.0).
    #~ jd2000 = 2451545.0 # the J2000 Julian Day Number
    #~ @date = "2000-01-01"
    #~ jd = Date.parse(@date).jd
    #~ puts "The Date being input for calculations is j2000 = #{@date} at 12:00 p.m. for JD"
    #~ puts "The JD = #{jd}"
    #~ # calculate time to julian centuries
    #~ t = time_julian_century(jd)

    # arc seconds are used for these terms as the data terms are using arc seconds.
    def delta_equinox(t = time_julian_century())
      t.nil? ? t = time_julian_century() : t      
      ma_moon = 485868.249036 + 1717915923.2178 * t[0] + 31.8792 * t[1] + 0.051635 * t[2] - 0.00024470 * t[3]
      ma_sun = 1287104.79305 + 129596581.0481 * t[0] - 0.5532 * t[1] + 0.000136 * t[2] - 0.00001149 * t[3]
      md_moon = 335779.526232 + 1739527262.8478 * t[0] - 12.7512 * t[1] - 0.001037 * t[2] + 0.00000417 * t[3]
      me_moon = 1072260.70369 + 1602961601.2090 * t[0] - 6.3706 * t[1] + 0.006593 * t[2] - 0.00003169 * t[3]
      omega = 450160.398036 - 6962890.5431 * t[0] + 7.4722 * t[1] + 0.007702 * t[2] - 0.00005939 * t[3]

      # declare and clear these two variables for the sigma loop
      delta_psi, delta_eps = 0, 0
      
      rows = @data.size - 1
      for i in 0..rows
        fma_moon  = data[i][10].to_i
        fma_sun    = data[i][11].to_i
        fmd_moon  = data[i][12].to_i
        fme_moon  = data[i][13].to_i
        fomega      = data[i][14].to_i
        sine = sind(fma_moon * ma_moon +
            fma_sun * ma_sun +
            fmd_moon * md_moon +
            fme_moon * me_moon +
            fomega * omega)
        cosine = cosd(fma_moon * ma_moon +
            fma_sun * ma_sun +
            fmd_moon * md_moon +
            fme_moon * me_moon +
            fomega * omega)
        delta_psi +=                (data[i][15].to_f +
            data[i][16].to_f * t[0]) * sine +
          data[i][17].to_f * cosine
              
        delta_eps +=                  (data[i][18].to_f +
            data[i][19].to_f * t[0]) * cosine +
          data[i][20].to_f  * sine
      end
    
    
      #~ eps0 = to_deg(84381.405984 - 168612.3684 * t[0] - 0.659 * t[1] + 7.212 * t[2])
      #~ eps0 = mean_obliquity_of_ecliptic(t)
      #~ eps = eps0 + to_deg(delta_eps)
      delta_eps = to_deg(delta_eps)# * ARCSEC
      delta_psi = to_deg(delta_psi)# * ARCSEC
      #~ eoe = 240 * to_deg(delta_psi) * Math::cos(Math::PI / 180 * eps)  # not in arc seconds so use Math::PI / 180
      #~ gmst = mean_longitude_aries(t) / 15.0
      #~ gast = gmst + eoe / ARCSEC
      [delta_eps,  delta_psi]
    end
  end
end