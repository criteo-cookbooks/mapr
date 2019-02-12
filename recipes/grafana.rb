#
# Cookbook Name:: mapr
# Recipe:: grafana
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'mapr'

package 'mapr-grafana' do
  action :upgrade
end

include_recipe 'mapr::config'
