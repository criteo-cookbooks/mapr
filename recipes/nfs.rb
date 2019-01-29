#
# Cookbook Name:: mapr
# Recipe:: nfs
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'mapr'

package node['mapr']['nfs']['packages'] do
  action :upgrade
end

# Create /mapr directory
directory '/mapr' do
  action :create
end

template '/opt/mapr/conf/mapr_fstab' do
  source 'mapr_fstab.erb'
  variables(options: node['mapr']['nfs']['mount_options'])
end

include_recipe 'mapr::config'
