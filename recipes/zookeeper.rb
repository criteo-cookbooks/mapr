#
# Cookbook Name:: mapr
# Recipe:: zookeeper
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'mapr'

# Install the package
package 'mapr-zookeeper' do
  action :upgrade
end

# TODO: In case of kerberos is activated, we should
# deactivate the simple-auth system

# Create and change owner for /opt/mapr/zkdata
directory node['mapr']['zookeeper']['config']['dataDir'] do
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  action :create
  recursive true
end

file File.join(node['mapr']['zookeeper']['dir'], 'zookeeperversion') do
  content node['mapr']['zookeeper']['version']
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
end

file File.join(node['mapr']['zookeeper']['config']['dataDir'], 'myid') do
  content node['mapr']['zookeeper']['my_id'].to_s
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
end

# Generate the configuration
#  TODO: The code is not that readable, is there a better way to manager ? let's think about it :p
config = Mapr::AttributeMerger.new node['mapr']['zookeeper']['config']
config.merge(true, node['mapr']['cluster']['nodes']['zookeeper']
                  .map
                  .with_index
                  .map { |node, index| ["server.#{index}", node + ':2888:3888'] }
                  .to_h,)

config.merge(true, Hash['mapr.cldbkeyfile.location' => File.join(node['mapr']['config']['config_dir'], 'cldb.key')])

config.merge(node['mapr']['cluster']['config']['security']['secure'], Hash['authMech' => 'MAPR-SECURITY'])
config.merge(node['mapr']['cluster']['config']['security']['secure'], node['mapr']['zookeeper']['security']['config'])

template ::File.join(node['mapr']['zookeeper']['dir'], "zookeeper-#{node['mapr']['zookeeper']['version']}", 'conf', 'zoo.cfg') do
  source 'conf.erb'
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
  variables(config: config.hash)
end

# Replace the default systemd service unit to make it compatible with systemd-219-67
template '/etc/systemd/system/mapr-zookeeper.service' do
  source 'systemd_zookeeper.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(user: node['mapr']['config']['owner'])
end

service 'mapr-zookeeper' do
  action %w[start enable]
end

#### Common configuration
include_recipe 'mapr::config'
