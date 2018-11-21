#
# Cookbook Name:: mapr
# Recipe:: warden
#
# Copyright:: 2018, The Authors, All Rights Reserved.

template File.join(node['mapr']['config']['config_dir'], 'warden.conf') do
  source 'conf.erb'
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
  variables(config: node['mapr']['warden']['config'])
end
