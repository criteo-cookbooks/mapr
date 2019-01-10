# Configure all the service from this point
config = Mapr::AttributeMerger.new(node['mapr']['hadoop']['config'])
config.merge(Mapr::NodeType.resourcemanager?, node['mapr']['hadoop']['resourcemanager']['config'])
config.merge(Mapr::NodeType.storage?, node['mapr']['hadoop']['storage']['config'])
config.merge(Mapr::NodeType.compute?, node['mapr']['hadoop']['compute']['config'])

hadoop_config_path = ::File.join(node['mapr']['hadoop']['dir'], "hadoop-#{node['mapr']['hadoop']['version']}", 'etc', 'hadoop')
config.hash.each do |config_name, local_config|
  template File.join(hadoop_config_path, "#{config_name}-site.xml") do
    source 'conf.xml.erb'
    variables(config: local_config)
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
    mode node['mapr']['config']['mode']
  end
end

# Generate the ssl configuration
node['mapr']['hadoop']['ssl'].each do |peer, ssl_config|
  template ::File.join(hadoop_config_path, "ssl-#{peer}.xml") do
    source 'conf.xml.erb'
    variables(config: ssl_config)
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
  end
  link ::File.join(node['mapr']['config']['config_dir'], "ssl-#{peer}.xml") do
    to ::File.join(hadoop_config_path, "ssl-#{peer}.xml")
  end
end
