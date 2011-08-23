load File.expand_path('../boot.rb', __FILE__)
require 'sinatra'
require 'active_record'

class Visit < ActiveRecord::Base
end

configure do
  ActiveRecord::Base.establish_connection( COUNT_CONF["db"] )
end

get '/?' do
  Visit.create :remote_ip => env["X_FORWARDED_FOR"] || env["REMOTE_ADDR"]
  @count = Visit.count
  <<-HTML
<!doctype html>

<style>
h1 { font-size: 400px; font-family: sans-serif; text-align: center; margin: 0 }
</style>

<h1>#{@count}<sup>th</sup></h1>
  HTML
end
