#
# Cookbook Name:: mapr
# Recipe:: opentsdb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'mapr'

package 'mapr-opentsdb' do
  action :upgrade
end

##### Generating the default configuration
include_recipe 'mapr::config'
