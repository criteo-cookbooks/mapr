### Main attributes ###
default['mapr']['cluster_name'] = 'default-cluster'
default['mapr']['release']['version'] = '6.0.1'
default['mapr']['ecosystem']['version'] = '5.0'

default['mapr']['user'] = 'mapr'
default['mapr']['uid'] = 628
default['mapr']['group'] = 'mapr'
default['mapr']['gid'] = 628

### Repositories attributes ###
default['mapr']['repositories']['base_url'] = 'http://package.mapr.com/releases/'

default['mapr']['repositories']['release_url'] = ::File.join(
  default['mapr']['repositories']['base_url'],
  "v#{default['mapr']['release']['version']}",
  'redhat',
)

default['mapr']['repositories']['gpg_url'] = "#{default['mapr']['repositories']['base_url']}/pub/maprgpg.key"

default['mapr']['repositories']['ecosystem_url'] = ::File.join(
  default['mapr']['repositories']['base_url'],
  'MEP',
  "MEP-#{default['mapr']['ecosystem']['version']}",
  'redhat',
)

### Java Attributes ###
default['java']['install_flavor'] = 'openjdk'
default['java']['jdk_version'] = '8'

### Prerequisites ###
default['mapr']['prerequisite']['packages'] = %w[
  mc
  wget
  MySQL-python
]

## Sysctl ##
default['mapr']['sysctl']['vm.swappiness'] = 10
default['mapr']['sysctl']['net.ipv4.tcp_retries2'] = 5
default['mapr']['sysctl']['vm.overcommit_memory'] = 0

### Core attributes
default['mapr']['core']['packages'] = %w[
  mapr-core
  mapr-core-internal
  mapr-kafka
]

### Zookeeper Attributes ###
default['mapr']['zookeeper']['datadir'] = '/opt/mapr/zkdata'

### Compute Attributes ###
default['mapr']['compute']['packages'] = %w[
  mapr-mapreduce2
  mapr-nodemanager
]

### NFS Attributes ###
default['mapr']['nfs']['packages'] = %w[
  mapr-nfs
  nfs-utils
  rpcbind
]
default['mapr']['nfs']['mount_options'] = %w[
  nolock
  nfsvers=3
]

### CLDB attributes ###

### MCS attributes ###
