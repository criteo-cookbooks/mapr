#
# Cookbook Name:: mapr
# Recipe:: mast_gateway
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'mapr-mastgateway' do
  action :upgrade
end

include_recipe 'mapr::config'
warden_service 'mastgateway' do
  config node['mapr']['warden']['mastgateway']['config']
  config_dir node['mapr']['config']['config_dir']
end
