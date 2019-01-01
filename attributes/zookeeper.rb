### Global configuration
include_attribute 'mapr::config'

### Zookeeper Attributes ###
default['mapr']['zookeeper']['version'] = '3.4.5'
# Zookeeper doesn't obey to the same syntax as other service do
default['mapr']['zookeeper']['dir'] = '/opt/mapr/zookeeper/'
default['mapr']['zookeeper']['config'] = {
    'tickTime' => 2000,
    # The number of ticks that the initial
    # synchronization phase can take
    'initLimit' => 20,
    # The number of ticks that can pass between
    # sending a request and getting an acknowledgement
    'syncLimit' => 10,
    # the directory where the snapshot is stored.
    'dataDir' => '/opt/mapr/zkdata',
    # the port at which the clients will connect
    'clientPort' => 5181,
    # max number of client connections
    'maxClientCnxns' => 1000,
    # autopurge interval - 24 hours
    'autopurge.purgeInterval' => 24,
    # superuser to allow zk nodes delete
    'superUser' => 'mapr',
    # readuser to allow read zk info for authenticated clients
    'readUser' => 'anyone',
    # security provider name
    'authMech' => 'SIMPLE-SECURITY',
    # Allow the below option if you want security based on the key
    # 'authMech' => 'MAPR-SECURITY',
    # security auth provider
    'authProvider.1' => 'org.apache.zookeeper.server.auth.SASLAuthenticationProvider',
    # use maprserverticket not userticket for auth
    'mapr.usemaprserverticket' => true,
}

default['mapr']['zookeeper']['security']['config'] = {
    'quorum.auth.enableSasl' => true,
    'quorum.auth.learnerRequireSasl' => true,
    'quorum.auth.serverRequireSasl' => true,
    'quorum.auth.server.saslLoginContext' => 'Server',
    'quorum.auth.server.saslLoginContext' => 'Server',
    'quorum.cnxn.threads.size' => 20,
}

default['mapr']['zookeeper']['my_id'] = 0
