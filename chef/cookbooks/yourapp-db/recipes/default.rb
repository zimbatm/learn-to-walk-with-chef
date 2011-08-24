include_recipe "yourapp-base"

include_recipe "mysql::server"

mysql_connection_info = {:host => "localhost", :username => 'debian-sys-maint', :password => node['mysql']['server_debian_password']}

mysql_database "yourapp" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "yourapp" do
  connection mysql_connection_info
  password node[:yourapp][:mysql_password]
  database_name "yourapp"
  #host '%'
  #privileges [:select, :update, :insert]
  action :grant
end

