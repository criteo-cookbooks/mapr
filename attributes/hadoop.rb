### Global configuration
include_attribute 'mapr::config'

### Zookeeper Attributes ###
default['mapr']['hadoop']['version'] = '2.7.0'
# Zookeeper doesn't obey to the same syntax as other service do
default['mapr']['hadoop']['dir'] = '/opt/mapr/hadoop/'
default['mapr']['hadoop']['config'] = {
  'yarn' => {},
  'core' => {},
  'hdfs' => {},
}

default['mapr']['hadoop']['resourcemanager']['config'] = {
  'yarn' => {},
  'core' => {},
  'hdfs' => {},
  'mapred' => {},
}

default['mapr']['hadoop']['compute']['config'] = {
  'yarn' => {},
  'core' => {},
  'hdfs' => {},
  'mapred' => {},
}

default['mapr']['hadoop']['storage']['config'] = {
  'yarn' => {},
  'core' => {},
  'hdfs' => {},
  'mapred' => {},
}
