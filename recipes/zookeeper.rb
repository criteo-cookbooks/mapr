#
# Cookbook Name:: mapr
# Recipe:: zookeeper
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Create and change owner for /opt/mapr/zkdata
directory node['mapr']['zookeeper']['datadir'] do
  owner node['mapr']['user']
  group node['mapr']['group']
  action :create
end

package 'mapr-zookeeper'
