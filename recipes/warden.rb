#
# Cookbook Name:: mapr
# Recipe:: warden
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# TO Be updated for better views

config = Mapr::AttributeMerger.new node['mapr']['warden']['config']
config.merge(true,
             'zookeeper.servers' => node['mapr']['cluster']['nodes']['zookeeper']
                                        .product([node['mapr']['zookeeper']['config']['clientPort']])
                                        .map { |host, port| "#{host}:#{port}" }
                                        .join(','),)
template File.join(node['mapr']['config']['config_dir'], 'warden.conf') do
  source 'conf.erb'
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
  variables(config: config.hash)
end

template File.join(node['mapr']['config']['config_dir'], 'daemon.conf') do
  source 'conf.erb'
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
  variables(config: node['mapr']['warden']['daemon']['config'])
end
