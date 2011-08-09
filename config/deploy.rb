require 'bundler/capistrano'
require 'json'

set :application, "yourapp"

set :repository,  "TODO"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "vagrant"
set :use_sudo, true

role :web, "vagrant:2222"
role :db,  "vagrant:2222"

namespace :deploy do
  task :start, :roles => [:web] do
    run "thin start"
  end

  task :stop, :roles => [:web] do
    run "thin stop"
  end

  task :restart, :roles => :web do
    run "thin reload"
  end

  task :bootstrap do
    put File.read("script/bootstrap"), "last-bootstrap"
    sudo "sh last-bootstrap"
  end
  before "deploy:setup", "deploy:bootstrap"

  task :chef_solo do
    node_config = {
      :yourapp => {
        :root => current_path,
        :other_app_specific_value__or_not => 42
      },
      :run_list => ["should-be-the-roles-for-the-box"]
    }
    put(JSON.pretty_generate(node_config), "#{release_path}/config/chef-solo.json")
    sudo "chef-solo -c #{release_path}/config/chef-solo.rb -j #{release_path}/config/chef-solo.json"
  end
  after "deploy:update_code", "deploy:chef_solo"

end
