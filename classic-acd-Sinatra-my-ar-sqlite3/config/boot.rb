# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
Bundler.setup

# Require gems we care about
require 'rubygems'

require 'active_record'
require 'active_support/all'
#require 'bcrypt'
#require 'config'
# This will load your environment variables from .env when your apps starts
require 'dotenv'
Dotenv.load
require 'erb'
require 'faker'
require 'flowdock'
require 'logger'
require 'omniauth-github'
require 'pathname'
require 'pg'
require 'pry-byebug'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/config_file' 
require 'sinatra/flash'
require 'sinatra/json'
require "sinatra/reloader" 
require 'sinatra/respond_with'
require 'sqlite3'
require 'uri'
disable :run
