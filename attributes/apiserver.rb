default['mapr']['apiserver']['config'] = {
  'ojai.cache.size' => 64,
  'mapr.webui.https.port' => 8443,
  'doc.url' => 'https://maprdocs.mapr.com',
  'proxy.zkservices' => 'elasticsearch, opentsdb',
}
default['mapr']['apiserver']['config_dir'] = '/opt/mapr/apiserver/conf'
