include_recipe "yourapp-base"

%w[redis-server mysql-server].each do |pkg|
  package pkg do
    action :install
  end
end
