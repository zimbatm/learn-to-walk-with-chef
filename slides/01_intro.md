!SLIDE center
# Learn to walk with Chef #

<embed src="http://www.dollbabi.com/flash/QWOP.swf" quality="high"
type="application/x-shockwave-flash" width="640" height="400" menu="0">

<script>
// disable P key for QWOP ;-)
runPreShow = function(){}
</script>

!SLIDE bullets incremental

# Your host #

* Jonas Pfenniger aka @zimbatm

!SLIDE center

<img src="Audiance_Advisory.png" style="position: absolute; top: 0">

!SLIDE bullets incremental
# The plan #

* Use Chef to configure the machines
* Keep Capistrano to deploy your code
* Use Vagrant to mimic the production environment locally

!SLIDE bullets incremental
# YourApp #

* Counting the visits
* of your visit counting site
* <a href="http://localhost:9292" target="_blank">Demo</a>
* <a href="http://github.com/zimbatm/learn-to-walk-with-chef">github.com/zimbatm/learn-to-walk-with-chef</a>

!SLIDE bullets
# Chef core #

* chef-solo
* JSON tree
* Cookbooks

!SLIDE bullets
# Chef JSON tree #

* cookbook attributes
* cookbook providers
* user values
* `ohai`

!SLIDE bullets
# Chef Cookbooks #

* base
* attributes, providers, recipes, files and templates
* //wiki.opscode.com/display/chef/Resources
* //github.com/opscode/cookbooks

!SLIDE bullets
# Bootstrap & Capistrano #

* Ruby version ?
* When, what, how ?

!SLIDE
# Vagrant #

    @@@ sh
    # Install VirtualBox, then...
    $ gem install vagrant
    $ vagrant up

!SLIDE bullets incremental
# Vagrant #

* Unable to SSH on the VM
* -> Login vagrant/vagrant in the GUI and run `sudo dhclient`
* Internet not available from within the VM
* -> set /etc/resolv.conf's nameserver to 8.8.8.8
* Crashes your computer on I/O

!SLIDE
# Blueprint #


    # Did you miss something ? Use blueprint.py
    $ git clone \
      https://github.com/devstructure/blueprint
    $ cd blueprint && make install
    $ blueprint create check
    $ blueprint show -C check
    ... generates check/recipe/default.rb and stuff

!SLIDE
# Cheers ! #

# Questions ? #
