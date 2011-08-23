set :application, "yourapp"

set :default_stage, "development"
set :stages, %w(production staging development)

require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'json'

set :repository,  "git@github.com:zimbatm/learn-to-walk-with-chef.git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git

namespace :deploy do
  task :start, :roles => :web do
    run "thin start"
  end

  task :stop, :roles => :web do
    run "thin stop"
  end

  task :restart, :roles => :web do
    run "thin reload"
  end
end

namespace :chef do
  desc "Prepares the target machine for chef"
  task :bootstrap do
    put File.read("script/bootstrap"), "last-bootstrap"
    sudo "sh last-bootstrap"
  end
  before "deploy:setup", "chef:bootstrap"

  desc "Applies the recipes to the target machine"
  task :chef_solo do
    node_config = JSON.pretty_generate(
      :yourapp => {
        :root => current_path,
        :stage => stage,
        :other_app_specific_value__or_not => 42
      },
      :run_list => ["should-be-the-roles-for-the-box"]
    )
    put(node_config, "#{release_path}/config/chef-solo.json")
    sudo "chef-solo -c #{release_path}/config/chef-solo.rb -j #{release_path}/config/chef-solo.json"
  end
  #after "deploy:update_code", "deploy:chef_solo"
  before "bundle:install", "deploy:chef_solo"
end
