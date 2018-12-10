#
# Cookbook Name:: mapr
# Recipe:: cldb
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'mapr::default'

package 'mapr-cldb' do
  action :upgrade
end
Chef::Log.info('test here')
template File.join(node['mapr']['config']['config_dir'], 'cldb.conf') do
  source 'conf.erb'
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
  variables(config: node['mapr']['cldb']['config'].merge(
    # ZooKeeper address
    'cldb.zookeeper.servers' =>
        node['mapr']['cluster']['nodes']['zookeeper']
            .product([node['mapr']['zookeeper']['config']['clientPort'].to_s])
            .map { |host, port| host + ':' + port }
            .join(','),
  ),)
end

## Include the configure recipe
include_recipe 'mapr::config'
