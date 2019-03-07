#
# Cookbook Name:: mapr
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Configure repositories
include_recipe 'mapr::repositories'

# Install java
include_recipe 'java::default'

# Create user and group mapr
group node['mapr']['config']['group']

ohai_resource = 'reload user information for mapr'

ohai ohai_resource do
  plugin 'user'
  action :nothing
end

user node['mapr']['config']['owner'] do
  comment 'MapR user'
  group node['mapr']['config']['group']
  notifies :reload, ohai_resource, :immediate
end

# Install required packages
package node['mapr']['prerequisite']['packages'] do
  action :upgrade
end

# Set specific sysctl config
node['mapr']['cluster']['sysctl']['config'].each do |param_name, value|
  sysctl_param param_name do
    value value
  end
end

include_recipe 'mapr::core'
include_recipe 'mapr::warden'
