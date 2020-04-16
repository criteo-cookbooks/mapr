#
# Cookbook Name:: mapr
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Configure repositories
include_recipe 'mapr::repositories'

# Install java
openjdk_install node['java']['jdk_version']

include_recipe 'mapr::users'

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
