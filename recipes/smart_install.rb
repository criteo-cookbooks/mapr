## A smart way to install the mapr-cluster
if Mapr::NodeType.empty?
  raise "node['mapr']['cluster']['components'] is empty.
Please specify the components you want to install/configure"
end


# Include the recipe for the appropriate services
include_recipe 'mapr::cldb' if Mapr::NodeType.cldb?
include_recipe 'mapr::resourcemanager' if Mapr::NodeType.resourcemanager?
include_recipe 'mapr::zookeeper' if Mapr::NodeType.zookeeper?
include_recipe 'mapr::mfs' if Mapr::NodeType.storage?
include_recipe 'mapr::mcs' if Mapr::NodeType.mcs?
include_recipe 'mapr::nfs' if Mapr::NodeType.nfs?
include_recipe 'mapr::grafana' if Mapr::NodeType.grafana?
include_recipe 'mapr::compute' if Mapr::NodeType.compute?
include_recipe 'mapr::hs' if Mapr::NodeType.hs?
include_recipe 'mapr::maMaprst_gateway' if Mapr::NodeType.mg?