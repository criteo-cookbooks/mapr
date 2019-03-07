#
# Cookbook Name:: mapr
# Recipe:: mcs
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'mapr'

package 'mapr-webserver' do
  action :upgrade
end

# Generating the configuration
apiserver_config = Mapr::AttributeMerger.new(node['mapr']['apiserver']['config'])
apiserver_config.merge(node['mapr']['cluster']['config']['security']['secure'], 'mapr.rest.auth.methods' => 'kerberos,basic')

template File.join(node['mapr']['apiserver']['config_dir'], 'properties.cfg') do
  source 'conf.erb'
  variables(config: apiserver_config.hash)
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
end

##### Generating the default configuration
include_recipe 'mapr::config'

directory ::File.dirname(node['mapr']['warden']['apiserver']['config']['service.logs.location']) do
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode 0o755
end

# Generate the warden.apiserver
warden_service 'apiserver' do
  config_dir node['mapr']['config']['config_dir']
  config node['mapr']['warden']['apiserver']['config']
end

directory ::File.join(::File.dirname(::File.dirname(node['mapr']['warden']['apiserver']['config']['service.logs.location'])), 'tmp') do
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode 0o755
end

file ::File.join(node['mapr']['apiserver']['config_dir'], 'apiserver.pid') do
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode 0o644
end
