include_recipe "yourapp-base"

include_recipe "nginx"
include_recipe "mysql::client"
include_recipe "logrotate"

template "#{node[:nginx][:dir]}/sites-available/yourapp" do
  source "yourapp-site.erb"
  owner "root"
  group "root"
  mode 0644
end

nginx_site "yourapp" do
  action :enable
end

logrotate_app "nginx-yourapp" do
  cookbook "logrotate"
  path "#{node[:nginx][:log_dir]}/yourapp.access.log"
  frequency "daily"
  rotate 30
  create "644 root adm"
end
