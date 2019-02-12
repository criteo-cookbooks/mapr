default['mapr']['warden']['compute']['config'] = {
  'services' => 'nodemanager:all:resourcemanager',
  'service.displayname' => 'NodeManager',
  'service.command.start' => '/opt/mapr/hadoop/hadoop-2.7.0/sbin/yarn-daemon.sh start nodemanager',
  'service.command.stop' => '/opt/mapr/hadoop/hadoop-2.7.0/sbin/yarn-daemon.sh stop nodemanager',
  'service.command.type' => 'BACKGROUND',
  'service.command.monitorcommand' => '/opt/mapr/hadoop/hadoop-2.7.0/sbin/yarn-daemon.sh status nodemanager',
  'service.port' => 8030,
  'service.ui.port' => 8042,
  'service.uri' => '/about',
  'service.baseservice' => '1',
  'service.logs.location' => '/opt/mapr/hadoop/hadoop-2.7.0/logs/',
  'service.process.type' => 'JAVA',
  'service.alarm.tersename' => 'nanmd',
  'service.alarm.label' => 'NodeManagerDown',
  # Memory allocation for NodeManager is only used
  # to calculate total memory required for all services to run
  # but -Xmx  itself is not set, allowing memory on
  # NodeManager to grow as needed
  # if upper limit on memory is strongly desired
  # set YARN_NODEMANAGER_HEAPSIZE env. variable in /opt/mapr/hadoop/hadoop-2.7.0/etc/hadoop/yarn-env.sh
  'service.heapsize.min' => 64,
  'service.heapsize.max' => 325,
  'service.heapsize.percent' => 2,
}
