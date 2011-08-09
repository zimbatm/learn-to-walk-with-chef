# Just a commont boot file to get the same environment in rake, sinatra and what else ?
unless defined? YOURAPP_ROOT
  YOURAPP_ROOT = File.expand_path('..', __FILE__)

  # this would be lib/ and app
  $:.unshift YOURAPP_ROOT

  ENV['RACK_ENV'] ||= "development"
  YOURAPP_ENV = ENV['RACK_ENV']

  require 'yaml'
  YOURAPP_CONF = YAML.load_file("config/config.yml")[YOURAPP_ENV]

  require 'rubygems'
  require 'bundler'

  # If you have mutliple apps but one Gemfile, don't use
  # Bundler.require, because it will load all gems, in all your apps
  # It's also mostly what makes bundler so slow
  Bundler.setup(:default, ENV['RACK_ENV'])
end
