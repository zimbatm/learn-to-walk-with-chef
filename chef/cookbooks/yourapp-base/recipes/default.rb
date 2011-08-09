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

# TODO: configure munin
include_recipe "munin"


include_recipe "motd-tail"
# Too much data is not good
file "/etc/update-motd.d/10-help-text" do
  action :delete
end
file "/etc/update-motd.d/51_update-motd" do
  action :delete
end

# sendmail to syslog mailer
package "logmail"

# Some nice to have utilities
package "htop"


package "libimage-exiftool-perl"

# TODO: redirect syslog to syslog-server
# TODO: configure logrotate

# Setup bash aliases
template "#{ENV['HOME']}/.bash_profile" do
  mode "0644"
  source "bash_profile.erb"
end
