default['mapr']['config']['owner'] = 'mapr'
default['mapr']['config']['group'] = 'mapr'
default['mapr']['config']['mode'] = 0o400
default['mapr']['config']['config_dir'] = '/opt/mapr/conf'

#### Hosting machine definition
default['mapr']['cluster']['nodes']['cldb'] = %w[cldb1 cldb2]
default['mapr']['cluster']['nodes']['rm'] = %w[rm1 rm2]
default['mapr']['cluster']['nodes']['zookeeper'] = %w[zk1 zk2 zk3]

##### Config of the mapr-cluster
default['mapr']['cluster']['config'] = {
  'name' => 'mapr.cluster.com',
  'security' => {
    'secure' => false,
    'kerberosEnable' => false,
    'cldbPrincipal' => '',
  },
}

## Sysctl ##
default['mapr']['cluster']['sysctl']['config'] = {
  'vm.swappiness' => 10,
  'net.ipv4.tcp_retries2' => 5,
  'vm.overcommit_memory' => 0,
}

#### Used for fast cluster install & config
default['mapr']['cluster']['components'] = %w[]
