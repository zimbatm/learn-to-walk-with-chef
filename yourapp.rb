load File.expand_path('../boot.rb', __FILE__)
require 'sinatra'
require 'yourapp_model'

before do
  @current_visit = Visit.create(:remote_ip => env["X_FORWARDED_FOR"])
end

get '/?' do
  "<h1><blink>This is your convoluted app"
end

get '/visits' do
  Visit.all.map(&:remote_ip).join(', ')
end
