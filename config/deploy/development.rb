# DEVELOPMENT-specific deployment configuration
# please put general deployment config in config/deploy.rb

set :user, "vagrant"
set :password, "vagrant"
set :use_sudo, true

role :web, "localhost:2222"
role :db,  "localhost:2222"

set :deploy_via, :copy
#set :copy_strategy, :export
