# Cookbook Name:: mapr
# Spec:: config
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
#
# Usage:
#   - Used for common configuration for all the component of MaprCluster

directory node['mapr']['config']['config_dir'] do
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode '0744'
end
# TODO: The code is not clearly readable
config = Mapr::AttributeMerger.new node['mapr']['cluster']['config']
config.merge(true, cldbs: node['mapr']['cluster']['nodes']['cldb']
                               .product([node['mapr']['cldb']['config']['cldb.port'].to_s])
                               .map { |host, port| host + ':' + port }
                               .join(' '),)

### Generate the mapr-clusters.conf
template File.join(node['mapr']['config']['config_dir'], 'mapr-clusters.conf') do
  source 'mapr-clusters.conf.erb'
  variables(config: config.hash)
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode '0744'
end

# Generated for security purpose, otherwise the default one is left untacted
template File.join(node['mapr']['config']['config_dir'], 'mapr.login.conf') do
  source 'mapr.login.conf.erb'
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  variables(mapr_principal:   "mapr/#{node['mapr']['cluster']['config']['name']}",
            mapr_keytab:      File.join(node['mapr']['config']['config_dir'], 'mapr.keytab'),
            spnego_principal: "HTTP/#{node['fqdn']}",
            spnego_keytab:    File.join(node['mapr']['config']['config_dir'], 'spnego.keytab'),)
end
include_recipe 'mapr::audit'
include_recipe 'mapr::security' if node['mapr']['cluster']['config']['security']['secure']
include_recipe 'mapr::hadoop'