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
#       by the cluster administrator, we did provide a
#       resource 'mapr_keytab' to help with it's creation

# Generating the cldb.key
# The key is only generated on cldb and zookeeper machines
if (Mapr::NodeType.cldb? || Mapr::NodeType.zookeeper?) && node['mapr']['cluster']['config']['security']['secure']
  file File.join(node['mapr']['config']['config_dir'], 'cldb.key') do
    content node['mapr']['security']['cldb.key']['content']
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
  end
end

# Generating the ssl files
node['mapr']['security']['ssl'].each do |name, description|
  file File.join(node['mapr']['config']['config_dir'], name) do
    content description['content']
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
    mode node['mapr']['config']['mode']
  end
end

# Generating the map server ticket file
template File.join(node['mapr']['config']['config_dir'], 'maprserverticket') do
  source 'maprserverticket.erb'
  variables(cluster_name: node['mapr']['cluster']['config']['name'],
            secret:       node['mapr']['security']['maprserverticket']['content'],)
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode node['mapr']['config']['mode']
end

node['mapr']['security']['jmx']['config'].each do |type, config|
  template File.join(node['mapr']['config']['config_dir'], "jmxremote.#{type}") do
    source 'jmxremote.erb'
    variables(config: config)
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
    mode node['mapr']['config']['mode']
  end
end
