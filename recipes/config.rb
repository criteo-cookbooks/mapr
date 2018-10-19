#
# Cookbook Name:: mapr
# Recipe:: config
#
# Copyright:: 2018, The Authors, All Rights Reserved.

mapr_configure_sh 'Initialization' do
  basic_opts(
    '-N' => node['mapr']['cluster_name'],
    '-u' => node['mapr']['user'],
    '-g' => node['mapr']['group'],
    '-C' => node['mapr']['platform']['cldb_hosts'].join(','),
    '-Z' => node['mapr']['platform']['zookeeper_hosts'].join(','),
  )
  additional_opts node['mapr']['configuration']['configure.sh']['additional_opts']
end

# This action will be called with notify when needed
mapr_configure_sh 'refresh roles' do
  action :nothing
end
