#
# Cookbook Name:: mapr
# Recipe:: mfs
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'mapr'

# Install MapR FileServer (MFS)
package 'mapr-fileserver' do
  action :upgrade
end

##### Generating the default configuration
include_recipe 'mapr::config'
include_recipe 'mapr::hadoop'
include_recipe 'mapr::disks'
