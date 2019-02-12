#
# Cookbook Name:: mapr
# Recipe:: config
#
# Copyright:: 2018, The Authors, All Rights Reserved.

config_dir = node['mapr']['config']['config_dir']

directory config_dir do
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode '0755'
end

# TODO: The code is not clearly readable
config = Mapr::AttributeMerger.new node['mapr']['cluster']['config']

config.merge(true, cldbs: node['mapr']['cluster']['nodes']['cldb']
                               .product([node['mapr']['cldb']['config']['cldb.port'].to_s])
                               .map { |host, port| host + ':' + port }
                               .join(' '),)

### Generate the mapr-clusters.conf
template File.join(config_dir, 'mapr-clusters.conf') do
  source 'mapr-clusters.conf.erb'
  variables(config: config.hash)
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode '0755'
end

# Generated for security purpose, otherwise the default one is left untacted
template File.join(config_dir, 'mapr.login.conf') do
  source 'mapr.login.conf.erb'
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode '0755'
  variables(mapr_principal:   "mapr/#{node['mapr']['cluster']['config']['name']}",
            mapr_keytab:      ::File.join(config_dir, 'mapr.keytab'),
            spnego_principal: "HTTP/#{node['fqdn']}",
            spnego_keytab:    ::File.join(config_dir, 'spnego.keytab'),)
end

file File.join(config_dir, 'env_override.sh') do
  content node['mapr']['cluster']['env_override.sh']['config']['content']
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode '0755'
end

include_recipe 'mapr::audit'
include_recipe 'mapr::security' if node['mapr']['cluster']['config']['security']['secure']
include_recipe 'mapr::hadoop'
