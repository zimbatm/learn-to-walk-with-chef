chef_root = File.expand_path('../../chef', __FILE__)

log_level   :info
cookbook_path %w(cookbooks upstream).map{|name| File.join(chef_root, name)}
role_path   File.join(chef_root, 'roles')
