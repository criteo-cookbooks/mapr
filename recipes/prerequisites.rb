#
# Cookbook Name:: mapr
# Recipe:: prerequisites
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Create user and group mapr
group node['mapr']['group']

user node['mapr']['user'] do
  comment 'MapR user'
  group node['mapr']['group']
end

# Configure repositories
include_recipe 'mapr::repositories'

# Install java
include_recipe 'java::default'

# Install required packages
package node['mapr']['prerequisite']['packages'] do
  action :upgrade
end

# Set specific sysctl configuration
node['mapr']['sysctl'].each do |param_name, value|
  sysctl_param param_name do
    value value
  end
end
