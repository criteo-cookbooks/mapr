### Main attributes ###
default['mapr']['core']['version'] = '6.0.1'
default['mapr']['expansionpack']['version'] = '6.0.0'

### Repositories attributes ###
base_url = 'http://package.mapr.com/releases/'

default['mapr']['repositories']['core_url'] = ::File.join(
  base_url,
  "v#{node['mapr']['core']['version']}",
  'redhat',
)

default['mapr']['repositories']['gpg_url'] = ::File.join(
  base_url,
  'pub/maprgpg.key',
)

default['mapr']['repositories']['expansionpack_url'] = ::File.join(
  base_url,
  'MEP',
  "MEP-#{node['mapr']['expansionpack']['version']}",
  'redhat',
)

### Java Attributes ###
default['java']['install_flavor'] = 'openjdk'
default['java']['jdk_version'] = '8'

### Prerequisites ###
default['mapr']['prerequisite']['packages'] = %w[
  MySQL-python
]

### Core attributes
default['mapr']['core']['packages'] = %w[
  mapr-core
  mapr-core-internal
]

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
### MFS attributes ###
# Disks to format and use
default['mapr']['mfs']['config']['disks'] = ::Mapr::DiskSetup.unpartitioned_disks(node)
# Number of disks in a storage pool
default['mapr']['mfs']['config']['stripe_width'] = 1
