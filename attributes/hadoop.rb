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

default['mapr']['hadoop']['ssl'] = {
  'client' => {
    'ssl.client.truststore.location' => '/opt/mapr/conf/ssl_truststore',
    'ssl.client.truststore.password' => 'mapr123',
    'ssl.client.truststore.type' => 'jks',
    'ssl.client.truststore.reload.interval' => '10000',
    'ssl.client.keystore.location' => '/opt/mapr/conf/ssl_keystore',
    'ssl.client.keystore.password' => 'mapr123',
    'ssl.client.keystore.keypassword' => 'mapr123',
    'ssl.client.keystore.type' => 'jks',
  },
  'server' => {
    'ssl.server.truststore.location' => '/opt/mapr/conf/ssl_truststore',
    'ssl.server.truststore.password' => 'mapr123',
    'ssl.server.truststore.type' => 'jks',
    'ssl.server.truststore.reload.interval' => '10000',
    'ssl.server.keystore.location' => '/opt/mapr/conf/ssl_keystore',
    'ssl.server.keystore.password' => 'mapr123',
    'ssl.server.keystore.keypassword' => 'mapr123',
    'ssl.server.keystore.type' => 'jks',
  },
}
