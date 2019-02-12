default['mapr']['warden']['resourcemanager']['config'] = {
  'services' => 'resourcemanager:all:cldb',
  'service.displayname' => 'ResourceManager',
  'service.command.start' => '/opt/mapr/hadoop/hadoop-2.7.0/sbin/yarn-daemon.sh start resourcemanager',
  'service.command.stop' => '/opt/mapr/hadoop/hadoop-2.7.0/sbin/yarn-daemon.sh stop resourcemanager',
  'service.command.type' => 'BACKGROUND',
  'service.command.monitorcommand' => '/opt/mapr/hadoop/hadoop-2.7.0/sbin/yarn-daemon.sh status resourcemanager',
  'service.port' => 8032,
  'service.ui.port' => 8088,
  'service.uri' => '/cluster',
  'service.baseservice' => 1,
  'service.logs.location' => '/opt/mapr/hadoop/hadoop-2.7.0/logs/',
  'service.process.type' => 'JAVA',
  'service.alarm.tersename' => 'narmd',
  'service.alarm.label' => 'ResourceManagerDown',
  # Memory allocation for ResourceManager is only used
  # to calculate total memory required for all services to run
  # but -Xmx  itself is not set, allowing memory on
  # ResourceManager to grow as needed
  # if upper limit on memory is strongly desired
  # set YARN_RESOURCEMANAGER_HEAPSIZE env. variable in /opt/mapr/hadoop/hadoop-2.7.0/etc/hadoop/yarn-env.sh
  'service.heapsize.min' => 256,
  'service.heapsize.max' => 5000,
  'service.heapsize.percent' => 10,

  # Extended Info for RM contains the port numbers it listens to.
  # These are default port values as specified in Yarn Configuration.
  # If these are changed in yarn-site.xml, they should be changed here
  # as well
  'service.extinfo.SCHEDULER_PORT' => 8030,
  'service.extinfo.WEBAPP_PORT' => 8088,
  'service.extinfo.WEBAPP_HTTPS_PORT' => 8090,
  'service.extinfo.RESOURCETRACKER_PORT' => 8031,
  'service.extinfo.ADMIN_PORT' => 8033,
}
