#
# Cookbook Name:: mapr
# Recipe:: jh (job-history server)
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'mapr'

package 'mapr-historyserver' do
  action :upgrade
end

include_recipe 'mapr::config'

warden_service 'hs' do
  config node['mapr']['warden']['hs']['config']
  config_dir node['mapr']['config']['config_dir']
end
