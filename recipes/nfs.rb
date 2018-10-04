#
# Cookbook Name:: mapr
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package node['mapr']['nfs']['packages']

# Create /mapr directory
directory '/mapr' do
  action :create
end

template '/opt/mapr/conf/mapr_fstab' do
  source 'mapr_fstab.erb'
  variables(options: node['mapr']['nfs']['mount_options'])
end
