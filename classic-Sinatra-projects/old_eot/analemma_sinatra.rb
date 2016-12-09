require 'sinatra/base'
require_relative 'lib/equation_of_time'

class AnalemmaDataTable < Sinatra::Base
  #~ before do
    @eot = EOT
    @start = Time.utc( 2013, "jan", 1, 12, 0, 0 ).to_s    
    @start_date = Date.parse( @start ).jd
    @finish = Time.utc( 2013, "dec", 31, 12, 0, 0 ).to_s
    @finish_date = Date.parse( @finish ).jd
    @data = ""

    for jd in @start_date..@finish_date

			timejc = @eot.time_julian_century( jd )
   
      @date = Date.jd( jd )    
      declination = @eot.degrees_to_s( @eot.declination( timejc ) )
      right_ascension = @eot.time_to_s( @eot.right_ascension( timejc ) / 15.0 )  
      delta_1 = @eot.display_equation_of_time( @eot.delta_orbit( timejc ) )			
			delta_2 = @eot.display_equation_of_time( @eot.delta_oblique( timejc ) )   
      delta_t = @eot.display_equation_of_time( @eot.equation_of_time(timejc) )

      #zenith = @eot.display_time(12 - equation_of_time)     
      
      #~ ds = (date + " " + delta_t + " " + declination).split
      table = <<eot
<tr><td><b> 
#@date </b></td><td><b> 
declination </b></td><td><b>
right_ascension </b></td><td><b>
delta_1 </b></td><td><b>
delta_2 </b></td><td><b>
delta_t </b></td></tr>
eot
      @data << table
    end
    #~ @ds = @data.join() 
  #~ end

  #~ get '/analemma' do     
html = <<eos
   
<h2>Analemma Data for 2013</h2></p>	 
<h3>Start date = #@start = #@start_date JDN</h3>
<h3>Finish date = #@finish = #@finish_date JDN</h3>  
<div><table border=\"1\" cellpadding=\"10\">
<tbody align=\"center\";>
<tr><th>Date</th>
<th>Declination(equitorial latitude)</th>
<th>Right Ascension(celestial position)</th>
<th>12:00 pm Delta Orbit</th>
<th>12:00 pm Delta Oblique</th>
<th>12:00 pm Delta Sum</th>    
#@data</tbody></table></div>

eos

    #~ html += "<div><table border=\"1\" cellpadding=\"10\">"
    #~ html += "<tbody align=\"center\";>"
    #~ html += "<tr><th>Date</th>"
    #~ html += "<th>Declination(tilt)</th>"
    #~ html += "<th>12:00 pm Delta</th>"
    #~ html += "<th>Zenith time</th></tr>"    
    #~ html += @data
    #~ html += "</tbody></table></div>"      
    #~ return html  
  #~ end
end
#~ puts html