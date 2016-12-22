require_relative 'lib/equation_of_time'

eot = Equation_of_Time.new()

start = "2013-3-20"
finish = "2013-3-20"
start_date = Date.parse(start)
finish_date = Date.parse(finish)
puts "start julian date = #{start_date.jd} date = #{start}"
puts "finish julian date = #{finish_date.jd} date = #{finish}"
ajd = start_date.ajd * 1.0
#~ for ajd in start_date.ajd..finish_date.ajd 
  #~ date = Date.ajd(ajd).to_s
for min in 0..59
  h = 10 / 24.0
  fd = h + min / 1440.0
  timejc = eot.time_julian_century(ajd + fd) 
  ml = eot.geometric_mean_longitude(timejc)
  tl = eot.true_longitude(timejc)
  ra = eot.right_ascension(timejc)
  puts "time\t\t\tmean longitude long\t\tright ascension"
	puts "10:#{min}\t\t\t#{ml}\t\t#{ra}\t\t#{}"
end
#~ end