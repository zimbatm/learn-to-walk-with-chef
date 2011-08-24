set :application, "yourapp"

set :default_stage, "development"
set :stages, %w(production staging development)

require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'json' # to generate the chef config

set :scm, :git
set :repository, "git@github.com:zimbatm/learn-to-walk-with-chef.git"
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true

set :mysql_password, "something random"

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

# Create the app's root_dir on every deploy
before "deploy:update", "deploy:setup"

namespace :db do
  # Use max_hosts to avoid concurency issues of migrations
  desc "Update the database schema"
  task :migrate, :max_hosts => 1 do
    run "#{rake} db:migrate"
  end
  after "deploy:update", "db:migrate"
end

namespace :chef do
  desc "Prepares the target machine for chef"
  task :bootstrap do
    put File.read("script/bootstrap"), "last-bootstrap"
    sudo "sh last-bootstrap"
  end
  before "deploy:update_code", "chef:bootstrap"

  desc "Applies the recipes to the target machine"
  task :chef_solo do
    sudo "chef-solo -c #{release_path}/config/chef-solo.rb -j #{release_path}/config/chef-solo.json"
  end
  #after "deploy:update_code", "chef:chef_solo"
  before "bundle:install", "chef:chef_solo"

  # Dispatch because Capistrano doesn't support the concept of
  # roles_for_the_current_server
  #
  # Yeah. It's ugly
  task :push_config do
    chef.web_config
    chef.db_config
  end
  before "chef:chef_solo", "chef:push_config"

  task :web_config, :roles => :web do
    push_config(:web)
  end

  task :db_config, :roles => :db do
    push_config(:db)
  end
end

def chef_push_config(*roles)
  node_config = JSON.pretty_generate(
    :yourapp => {
      :root => current_path,
      :stage => stage,
      :mysql_password => mysql_password,
      :other_app_specific_value__or_not => 42
    },
    :run_list => roles.map{|r| "role[#{[application,r].join('-')}]"}
  )
  put(node_config, "#{release_path}/config/chef-solo.json")
end
