#
# Cookbook Name:: mapr
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'mapr'

package 'mapr-webserver' do
  action :upgrade
end

# Generating the configuration

template File.join(node['mapr']['apiserver']['config_dir'], 'properties.cfg') do
  source 'conf.erb'
  variables(config: node['mapr']['apiserver']['config'])
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
end

##### Generating the default configuration
include_recipe 'mapr::config'
