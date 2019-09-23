default['mapr']['warden']['services'] = 'kvstore:all;hoststats:all:kvstore'
default['mapr']['warden']['config'] = {
  'service.command.hoststats.start' => '/opt/mapr/initscripts/mapr-hoststats start',
  'service.command.hoststats.stop' => '/opt/mapr/initscripts/mapr-hoststats stop',
  'service.command.hoststats.type' => 'BACKGROUND',
  'service.command.hoststats.monitorcommand' => '/opt/mapr/initscripts/mapr-hoststats status',
  'service.command.os.heapsize.percent' => 10,
  'service.command.os.heapsize.max' => 4000,
  'service.command.os.heapsize.min' => 256,
  'service.command.warden.heapsize.percent' => 1,
  'service.command.warden.heapsize.max' => 750,
  'service.command.warden.heapsize.min' => 64,
  'service.command.zk.heapsize.percent' => 1,
  'service.command.zk.heapsize.max' => 1500,
  'service.command.zk.heapsize.min' => 256,
  'service.nice.value' => -10,
  'nodes.mincount' => 1,
  'services.retries' => 3,
  'hoststats.port' => 5660,
  'mapr.home.dir' => '/opt/mapr',
  'centralconfig.enabled' => true,
  'pollcentralconfig.interval.seconds' => 300,
  'rpc.drop' => false,
  'hs.rpcon' => true,
  'hs.port' => 1111,
  'hs.host' => 'localhost',
  'services.retryinterval.time.sec' => 1800,
  'isM7' => 0,
  'log.retention.exceptions' => 'cldbaudit*,authaudit*,cldb*.log,hoststats.log,configure.log,mfs.log-*,nfsserver.log*',
  'services.memoryallocation.alarm.threshold' => 97,
  'isDB' => true,
  'service.command.kvstore.start' => '/opt/mapr/initscripts/mapr-mfs start',
  'service.command.kvstore.stop' => '/opt/mapr/initscripts/mapr-mfs stop',
  'service.command.kvstore.type' => 'BACKGROUND',
  'service.command.kvstore.monitor' => 'server/mfs',
  'service.command.kvstore.monitorcommand' => '/opt/mapr/initscripts/mapr-mfs status',
}

# For warden through cldb
default['mapr']['warden']['cldb']['services'] = 'cldb:all:kvstore'
default['mapr']['warden']['cldb']['config'] = {
  'service.command.cldb.start' => '/opt/mapr/initscripts/mapr-cldb start',
  'service.command.cldb.stop' => '/opt/mapr/initscripts/mapr-cldb stop',
  'service.command.cldb.type' => 'BACKGROUND',
  'service.command.cldb.monitor' => 'com.mapr.fs.cldb.CLDB',
  'service.command.cldb.monitorcommand' => '/opt/mapr/initscripts/mapr-cldb status',
  'service.command.cldb.heapsize.percent' => 8,
  'service.command.cldb.heapsize.max' => 4000,
  'service.command.cldb.heapsize.min' => 256,
  'cldb.port' => 7222,
  'kvstore.port' => 5660,
  'service.command.cldb.retryinterval.time.sec' => 600,
}

# For mfs through warden
default['mapr']['warden']['mfs']['services'] = ''
default['mapr']['warden']['mfs']['config'] = {
  'service.command.mfs.start' => '/opt/mapr/initscripts/mapr-mfs start',
  'service.command.mfs.stop' => '/opt/mapr/initscripts/mapr-mfs stop',
  'service.command.mfs.type' => 'BACKGROUND',
  'service.command.mfs.monitor' => 'server/mfs',
  'service.command.mfs.monitorcommand' => '/opt/mapr/initscripts/mapr-mfs status',
  'service.command.mfs.heapsize.percent' => 35,
  'service.command.mfs.heapsize.maxpercent' => 85,
  'service.command.mfs.heapsize.min' => 512,
  'mfs.port' => 5660,
}

# For nfs through warden
default['mapr']['warden']['nfs']['services'] = 'nfs:all:cldb'
default['mapr']['warden']['nfs']['config'] = {
  'service.command.nfs.start' => '/opt/mapr/initscripts/mapr-nfsserver start',
  'service.command.nfs.stop' => '/opt/mapr/initscripts/mapr-nfsserver stop',
  'service.command.nfs.type' => 'BACKGROUND',
  'service.command.nfs.monitor' => 'server/nfsserver',
  'service.command.nfs.monitorcommand' => '/opt/mapr/initscripts/mapr-nfsserver status',
  'service.command.nfs.heapsize.percent' => 3,
  'service.command.nfs.heapsize.min' => 64,
  'service.command.nfs.heapsize.max' => 1000,
}

default['mapr']['warden']['daemon']['config'] = {
  'mapr.daemon.user' => 'mapr',
  'mapr.daemon.group' => 'mapr',
  'mapr.daemon.runuser.warden' => 1,
}
