require_relative 'version'
require 'bigdecimal'
# 'date' provides two classes Date and DateTime.
require 'date'
# 'time' can do some parsing.
require 'time'
require 'safe_yaml'
require_relative 'eot/init'
require_relative 'eot/vars'
require_relative 'eot/utilities'
require_relative 'eot/angles'
require_relative 'eot/times'
require_relative 'eot/displays'
require_relative 'eot/nutation'

EOT.initialize


# for other time equations see:
# https://gist.github.com/2032003
# https://github.com/DouglasAllen/
