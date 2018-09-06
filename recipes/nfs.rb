#
# Cookbook Name:: mapr
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

node['mapr']['nfs']['packages'].each do |p|
  package p
end

# Create /mapr directory
directory '/mapr' do
  action :create
end

template '/opt/mapr/conf/mapr_fstab' do
  source 'mapr_fstab.erb'
  variables(options: node['mapr']['nfs']['mount_options'])
end
