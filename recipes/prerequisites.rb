#
# Cookbook Name:: mapr
# Recipe:: prerequisites
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Create user and group mapr
group node['mapr']['group'] do
  gid node['mapr']['gid']
end

user node['mapr']['user'] do
  comment 'MapR user'
  uid node['mapr']['uid']
  gid node['mapr']['gid']
  action :create
end

# Configure repositories
include_recipe 'mapr::repositories'

# Install java
include_recipe 'java::default'

# Install required packages
node['mapr']['prerequisite']['packages'].each do |p|
  package p
end

# Set specific sysctl configuration
node['mapr']['sysctl'].each do |param_name, value|
  sysctl_param param_name do
    value value
  end
end
