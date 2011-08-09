include_recipe "yourapp-base"

include_recipe "nginx"
include_recipe "mysql::client"
include_recipe "logrotate"

# TODO: restart services if file has changed
template "#{node[:nginx][:dir]}/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, resources(:service => "nginx")
end

execute "test-nginx-config" do
  command "nginx -t -c #{node[:nginx][:dir]}/nginx.conf"
  returns 0
  action :run
end

# TODO: get values from production
logrotate_app "nginx-panda" do
  cookbook "logrotate"
  path "/var/log/nginx/panda_error.log"
  frequency "daily"
  rotate 30
  create "644 root adm"
end

directory "/mnt/tmp"
directory "/mnt/chroot/mnt/tmp" do
  recursive true
end

# TODO: chroot and mount-bind
mount "/mnt/chroot/mnt/tmp" do
  device "/mnt/tmp"
  fstype "none"
  options "bind"
  action [:mount, :enable]
end
