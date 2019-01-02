# Configure all the service from this point
config = Mapr::AttributeMerger.new (node['mapr']['hadoop']['config'])
config.merge(Mapr::NodeType.resourcemanager?, node['mapr']['hadoop']['resourcemanager']['config'])
config.merge(Mapr::NodeType.storage?, node['mapr']['hadoop']['storage']['config'])
config.merge(Mapr::NodeType.compute?, node['mapr']['hadoop']['compute']['config'])

config.hash.each do |config_name, local_config|
  template File.join(node['mapr']['hadoop']['dir'], "hadoop-#{node['mapr']['hadoop']['version']}", 'etc', 'hadoop', "#{config_name}-site.xml") do
    source 'conf.xml.erb'
    variables(config: local_config)
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
    mode node['mapr']['config']['mode']
  end
end
