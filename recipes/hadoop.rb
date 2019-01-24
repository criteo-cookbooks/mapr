# Configure all the service from this point

hadoop_config_path = ::File.join(node['mapr']['hadoop']['dir'], "hadoop-#{node['mapr']['hadoop']['version']}", 'etc', 'hadoop')

node['mapr']['hadoop']['config'].each do |config_name, local_config|
  next if local_config.empty?
  config = Mapr::AttributeMerger.new(local_config)
  config.merge(Mapr::NodeType.resourcemanager?, node['mapr']['hadoop']['resourcemanager']['config'][config_name])
  config.merge(Mapr::NodeType.storage?, node['mapr']['hadoop']['storage']['config'][config_name])
  config.merge(Mapr::NodeType.compute?, node['mapr']['hadoop']['compute']['config'][config_name])

  template File.join(hadoop_config_path, "#{config_name}-site.xml") do
    source 'conf.xml.erb'
    variables(config: config.hash)
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
    mode '0755'
  end
end

# Generate the ssl configuration
node['mapr']['hadoop']['ssl'].each do |peer, ssl_config|
  template ::File.join(hadoop_config_path, "ssl-#{peer}.xml") do
    source 'conf.xml.erb'
    variables(config: ssl_config)
    owner node['mapr']['config']['owner']
    group node['mapr']['config']['group']
    mode '755'
  end
  link ::File.join(node['mapr']['config']['config_dir'], "ssl-#{peer}.xml") do
    to ::File.join(hadoop_config_path, "ssl-#{peer}.xml")
  end
end

directory ::File.join('/home', node['mapr']['config']['owner']) do
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode '0750'
end

file ::File.join('/home', node['mapr']['config']['owner'], 'hadoop-http-auth-signature-secret') do
  content node['mapr']['hadoop']['http']['hadoop-http-auth-signature-secret']
  owner node['mapr']['config']['owner']
  group node['mapr']['config']['group']
  mode '0740'
end
