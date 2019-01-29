default['mapr']['apiserver']['config'] = {
  'ojai.cache.size' => 64,
  'mapr.webui.https.port' => 8443,
  'doc.url' => 'https://maprdocs.mapr.com',
  'proxy.zkservices' => 'elasticsearch, opentsdb',
}

default['mapr']['apiserver']['config_dir'] = '/opt/mapr/apiserver/conf'

# This one will be installed with the warden_service resource.
default['mapr']['warden']['apiserver']['config'] = {
  'services' => 'apiserver:all:cldb;',
  'service.displayname' => 'ApiServer',
  'service.command.start' => '/opt/mapr/apiserver/bin/mapr-apiserver.sh start',
  'service.command.stop' => '/opt/mapr/apiserver/bin/mapr-apiserver.sh stop',
  'service.command.monitorcommand' => '/opt/mapr/apiserver/bin/mapr-apiserver.sh status',
  'service.command.type' => 'BACKGROUND',
  'service.port' => 8443,
  'service.ui.port' => 8443,
  'service.uri' => '/app/mcs',
  'service.baseservice' => 1,
  'service.logs.location' => '/opt/mapr/apiserver/logs/apiserver.log',
  'service.alarm.tersename' => 'naaapisrvd',
  'service.alarm.label' => 'ApiServerDown',
  'service.heapsize.max' => 1000,
  'service.heapsize.min' => 1000,
}
