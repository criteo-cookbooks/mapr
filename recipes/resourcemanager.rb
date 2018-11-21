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
