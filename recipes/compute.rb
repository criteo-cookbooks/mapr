#
# Cookbook Name:: mapr
# Recipe:: compute
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'mapr'

package node['mapr']['compute']['packages'] do
  action :upgrade
end

hadoop_config_path = ::File.join(node['mapr']['hadoop']['dir'], "hadoop-#{node['mapr']['hadoop']['version']}", 'etc', 'hadoop')

template File.join(hadoop_config_path, 'container-executor.cfg') do
  source 'conf.erb'
  variables(config: node['mapr']['hadoop']['config']['container-executor'])
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode '0744'
end

hadoop_bin_path = ::File.join(node['mapr']['hadoop']['dir'], "hadoop-#{node['mapr']['hadoop']['version']}", 'bin')
file ::File.join(hadoop_bin_path, 'container-executor') do
  owner 'root'
  group 'mapr'
  mode '6050'
end
include_recipe 'mapr::disks'
include_recipe 'mapr::config'
