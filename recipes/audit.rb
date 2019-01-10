#
# Cookbook Name:: mapr
# Recipe:: cldb
#
# Copyright:: 2018, The Authors, All Rights Reserved.
directory File.join(node['mapr']['config']['home'], 'mapr-cli-audit-log') do
  action :create
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode '740'
end
