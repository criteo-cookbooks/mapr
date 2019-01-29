#
# Cookbook Name:: mapr
# Recipe:: warden
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# TO Be updated for better views

config = Mapr::AttributeMerger.new node['mapr']['warden']['config']
config.merge(true, {
    'zookeeper.servers' => node['mapr']['cluster']['nodes']['zookeeper']
                               .product([node['mapr']['zookeeper']['config']['clientPort']])
                               .map {|host, port| "#{host}:#{port}"}
                               .join(',')})

config.merge(Mapr::NodeType.storage?, node['mapr']['warden']['mfs']['config'])
config.merge(Mapr::NodeType.cldb?, node['mapr']['warden']['cldb']['config'])
config.merge(Mapr::NodeType.nfs?, node['mapr']['warden']['nfs']['config'])

services = node['mapr']['warden']['services']

services += ";#{node['mapr']['warden']['cldb']['services']}" if Mapr::NodeType.cldb?
services += ";#{node['mapr']['warden']['mfs']['services']}" if Mapr::NodeType.storage?
services += ";#{node['mapr']['warden']['nfs']['services']}" if Mapr::NodeType.nfs?

template File.join(node['mapr']['config']['config_dir'], 'warden.conf') do
  source 'conf.erb'
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
  variables(config: config.hash.merge('services' => services))
end

template File.join(node['mapr']['config']['config_dir'], 'daemon.conf') do
  source 'conf.erb'
  owner 'root'
  group node['mapr']['config']['group']
  mode '744'
  variables(config: node['mapr']['warden']['daemon']['config'])
end
