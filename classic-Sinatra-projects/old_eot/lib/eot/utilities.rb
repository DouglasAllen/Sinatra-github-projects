module EOT
  class << self
    # these are for the math in all calculatins
    def bd(var = 0)
      BigDecimal(var.to_s) * 1.0
    end
  
    def truncate(x = 0)
      # Truncate large angles
      x.nil? ? x = 0 : x
      360.0 * ( x / 360.0 - Integer( x / 360.0))
    end

    def degrees_to_radians(degrees = 0)
      degrees.nil? ? degrees = 0 : degrees
      degrees * PI / 180.0
    end

    def radians_to_degrees(radians = 0)
      radians.nil? ? radians = 0 : radians
      radians * 180.0 / PI
    end

    def catch_nil_times(t = nil)
      t.nil? ? Time.new(2000, 01, 01, 12, 00, 00, "+00:00") : t # catch entered nils
    end
  end
end