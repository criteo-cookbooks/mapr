#
# Cookbook Name:: mapr
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'mapr'

package 'mapr-resourcemanager' do
  action :upgrade
end

##### Generating the default configuration
include_recipe 'mapr::config'
include_recipe 'mapr::hadoop'

warden_service 'resourcemanager' do
  config node['mapr']['warden']['resourcemanager']['config']
  config_dir node['mapr']['config']['config_dir']
end