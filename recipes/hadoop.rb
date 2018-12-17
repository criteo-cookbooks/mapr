# Configure all the service from this point
_config = Mapr::AttributeMerger.new node['mapr']['hadoop']['config']
_config.merge Mapr::NodeType.resourcemanager?, node['mapr']['hadoop']['resourcemanager']['config']
_config.merge Mapr::NodeType.storage?, node['mapr']['hadoop']['storage']['config']
_config.merge Mapr::NodeType.compute?, node['mapr']['hadoop']['compute']['config']

_config.hash.each do |config_name, config|
  template File.join(node['mapr']['hadoop']['dir'], "hadoop-#{node['mapr']['hadoop']['version']}", 'conf', "#{config_name}-site.xml") do
    source 'conf.xml'
    variables(config: config)
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
    mode node['mapr']['config']['mode']
  end
end
