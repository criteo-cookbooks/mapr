# Cookbook Name:: mapr
# Spec:: config
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
#
# Usage:
#   - Used for common configuration for all the component of MaprCluster

# TODO: The code is not clearly readable
_config = Mapr::AttributeMerger.new node['mapr']['cluster']['config']
_config.merge true, cldb: node['mapr']['cluster']['nodes']['cldb']
  .product([node['mapr']['cldb']['config']['cldb.port'].to_s])
  .map { |host, port| host + ':' + port }
  .join(' ')

### Generate the mapr-clusters.conf
template File.join(node['mapr']['config']['config_dir'], 'mapr-clusters.conf') do
  source 'mapr-clusters.conf.erb'
  variables(config: _config)
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
end

# Generated for security purpose, otherwise the default one is left untacted
template File.join(node['mapr']['config']['config_dir'], 'mapr.login.conf') do
  source 'mapr.login.conf.erb'
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  variables(mapr_principal:   "mapr/#{node['mapr']['cluster']['config']['name']}",
            keytab_path:      File.join(node['mapr']['config']['config_dir'], 'mapr.keytab'),
            spnego_principal: "HTTP/#{node['fqdn']}",)
end
include_recipe 'mapr::security' if node['mapr']['cluster']['config']['security']['secure']
