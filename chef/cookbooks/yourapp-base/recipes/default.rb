include_recipe "apt"
include_recipe "ubuntu"
include_recipe "build-essential"
include_recipe "git"

# add the PandaStream repo
apt_repository "panda" do
  uri "http://panda-apt.s3.amazonaws.com/"
  distribution node['lsb']['codename']
  components ["main"]
  key "http://panda-apt.s3.amazonaws.com/panda.pub"
  action :add
end

include_recipe "motd-tail"
# Too much data is not good
file "/etc/update-motd.d/10-help-text" do
  action :delete
end
file "/etc/update-motd.d/51_update-motd" do
  action :delete
end


# Some nice to have utilities
package "logmail" # sendmail to syslog mailer
package "htop"
package "iotop"
package "vim-nox"

# Setup bash aliases
template "#{ENV['HOME']}/.bash_profile" do
  mode "0644"
  source "bash_profile.erb"
end

# Gem system dependencies
include_recipe "mysql::client" # for mysql2 obviously

