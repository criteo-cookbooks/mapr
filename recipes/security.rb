#
# Cookbook Name:: mapr
# Recipe:: security
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
#
#
#
#     ATTENTION:
#           Keytab creation and management should be managed
#       by the cluster administrator

# Generating the cldb.key
# The key is only generated on cldb and zookeeper machines

config_dir = node['mapr']['config']['config_dir'].freeze

file File.join(config_dir, 'cldb.key') do
  content node['mapr']['security']['cldb.key']['content']
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  only_if { Mapr::NodeType.cldb? || Mapr::NodeType.zookeeper? }
end

# Generating the ssl files
node['mapr']['security']['ssl'].each do |name, description|
  file File.join(config_dir, name) do
    content description['content']
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
    mode name.eql?('ssl_truststore') ? '0644' : '0640'
  end
end

# Generating the map server ticket file
template File.join(config_dir, 'maprserverticket') do
  source 'maprserverticket.erb'
  variables(cluster_name: node['mapr']['cluster']['config']['name'],
            secret:       node['mapr']['security']['maprserverticket']['content'],)
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
end

node['mapr']['security']['jmx']['config'].each do |type, config|
  template File.join(config_dir, "jmxremote.#{type}") do
    source 'jmxremote.erb'
    variables(config: config)
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
    mode node['mapr']['config']['mode']
  end
end
