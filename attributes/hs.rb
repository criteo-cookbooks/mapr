default['mapr']['warden']['hs']['config'] = {
  'services' => 'historyserver:1:resourcemanager',
  'service.displayname' => 'JobHistoryServer',
  'service.command.start' => '/opt/mapr/hadoop/hadoop-2.7.0/sbin/mr-jobhistory-daemon.sh start historyserver',
  'service.command.stop' => '/opt/mapr/hadoop/hadoop-2.7.0/sbin/mr-jobhistory-daemon.sh stop historyserver',
  'service.command.type' => 'BACKGROUND',
  'service.command.monitorcommand' => '/opt/mapr/hadoop/hadoop-2.7.0/sbin/mr-jobhistory-daemon.sh status historyserver',
  'service.port' => 10_020,
  'service.ui.port' => 19_888,
  'service.uri' => '/jobhistory',
  'service.logs.location' => '/opt/mapr/hadoop/hadoop-2.7.0/logs',
  'service.baseservice' => 1,
  'service.process.type' => 'JAVA',
  'service.alarm.tersename' => 'nasjhsd',
  'service.alarm.label' => 'JobHistoryServerDown',
  # Memory allocation for HistoryServer is only used
  # to calculate total memory required for all 'services to run
  # but -Xmx  itself is not set, allowing memory on
  # HistoryServer to grow as needed
  # if upper limit on memory is strongly desired
  # set HADOOP_JOB_HISTORYSERVER_HEAPSIZE env. variable in /opt/mapr/hadoop/hadoop-2.7.0/etc/hadoop/mapred-env.sh
  'service.heapsize.min' => 64,
  'service.heapsize.max' => 750,
  'service.heapsize.percent' => 1,
}
