# DEVELOPMENT-specific deployment configuration
# please put general deployment config in config/deploy.rb

set :user, "vagrant"
set :password, "vagrant"
set :use_sudo, true

role :web, "localhost:2222"
role :db,  "localhost:2222"

# Use local code for offline development
set :repository, "."
set :scm, :none
set :deploy_via, :copy
#set :copy_cache, true
set :copy_exclude, ".git/*"

set :mysql_password, "foobar"

namespace :chef do
  task :push_config do
    # Both roles, please
    chef_push_config(:web, :db)
  end
end
