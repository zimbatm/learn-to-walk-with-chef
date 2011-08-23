# vim: ft=ruby
Vagrant::Config.run do |config|
  config.vm.box = "lucid64"
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

  # In some cases, the DHCP doesn't come up
  # login as vagrant/vagrant and type `sudo dhclient eth0`
  config.vm.boot_mode = :gui

=begin
  # what you can do without capistrano
  config.vm.provision :shell, :path => "script/bootstrap"
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef/cookbooks", "chef/upstream"]
    chef.roles_path = "chef/roles"

    chef.add_role "yourapp-web"
    chef.add_role "yourapp-app"
    chef.add_role "yourapp-db"

    chef.json(
      :yourapp => { :root => "/vagrant" }
    )
  end
=end

end
