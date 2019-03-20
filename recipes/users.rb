#
# Cookbook Name:: mapr
# Recipe:: users
#
# Copyright:: 2019, The Authors, All Rights Reserved.

group node['mapr']['config']['group']

user node['mapr']['config']['owner'] do
  comment 'MapR user'
  group node['mapr']['config']['group']
end
