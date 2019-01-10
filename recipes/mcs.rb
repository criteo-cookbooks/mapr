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
config = Mapr::AttributeMerger.new(node['mapr']['apiserver']['config'])
config.merge(node['mapr']['cluster']['config']['security']['secure'], 'mapr.rest.auth.methods' => 'kerberos,basic')

template File.join(node['mapr']['apiserver']['config_dir'], 'properties.cfg') do
  source 'conf.erb'
  variables(config: config.hash)
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
end

##### Generating the default configuration
include_recipe 'mapr::config'
