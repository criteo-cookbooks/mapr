### Global configuration
include_attribute 'mapr::config'

### Zookeeper Configuration
include_attribute 'mapr::zookeeper'

default['mapr']['cldb']['config'] = {
  #
  # CLDB Config file.
  # Properties defined in this file are loaded during startup
  # and are valid for only CLDB which loaded the config.
  # These parameters are not persisted anywhere else.
  #
  # Wait until minimum number of fileserver register with
  # CLDB before creating Root Volume
  'cldb.min.fileservers' => 1,
  # CLDB listening port
  'cldb.port' => 7222,
  # Number of worker threads
  'cldb.numthreads' => 10,
  # CLDB webport
  'cldb.web.port' => 7221,
  # CLDB https port
  'cldb.web.https.port' => 0,
  # Disable duplicate hostid detection
  'cldb.detect.dup.hostid.enabled' => false,
  # cldb.enable.memory.tracker=true
  # Deprecated: This param is no longer supported. To configure
  # the container cache, use the param cldb.containers.cache.percent
  # Number of RW containers in cache
  'cldb.containers.cache.entries' => 1_000_000,
  #
  # Percentage (integer) of Xmx setting to be used for container cache
  'cldb.containers.cache.percent' => 20,
  #
  # Topology script to be used to determine
  # Rack topology of node
  # Script should take an IP address as input and print rack path
  # on STDOUT. eg
  # $>/home/mapr/topo.pl 10.10.10.10
  # $>/mapr-rack1
  # $>/home/mapr/topo.pl 10.10.10.20
  # $>/mapr-rack2
  'net.topology.table.file.name' => '',
  #
  # Topology mapping file used to determine
  # Rack topology of node
  # File is of a 2 column format (space separated)
  # 1st column is an IP address or hostname
  # 2nd column is the rack path
  # Line starting with '#' is a comment
  # Example file contents
  # 10.10.10.10 /mapr-rack1
  # 10.10.10.20 /mapr-rack2
  # host.foo.com /mapr-rack3
  # net.topology.table.file.name=/home/mapr/topo.txt
  # Hadoop metrics jar version
  'hadoop.version' => '2.7.0',
  # CLDB JMX remote port
  'cldb.jmxremote.port' => 7220,
  'num.volmirror.threads' => 1,
  # Set this to set the default topology for all volumes and nodes
  # The default for all volumes is /data by default
  # UNCOMMENT the below to change the default topology.
  # For e.g., set cldb.default.topology=/mydata to create volumes
  # in /mydata topology and to place all nodes in /mydata topology
  # by default
  'cldb.default.topology' => '',
  # cleanup.pool.threads.count=2
  'enable.replicas.invariant.check' => false,
  # cldb.enable.memory.tracker=true
}
