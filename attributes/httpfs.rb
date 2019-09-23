default['mapr']['httpfs']['nb_servers'] = 1

default['mapr']['warden']['httpfs']['config']['services'] = "httpfs:#{node['mapr']['httpfs']['nb_servers']}:cldb"
default['mapr']['warden']['httpfs']['config']['service.displayname'] = 'Httpfs'
default['mapr']['warden']['httpfs']['config']['service.command.start'] = '/opt/mapr/httpfs/httpfs-1.0/sbin/httpfs.sh start'
default['mapr']['warden']['httpfs']['config']['service.command.stop'] = '/opt/mapr/httpfs/httpfs-1.0/sbin/httpfs.sh stop'
default['mapr']['warden']['httpfs']['config']['service.command.type'] = 'BACKGROUND'
default['mapr']['warden']['httpfs']['config']['service.command.monitorcommand'] = '/opt/mapr/httpfs/httpfs-1.0/sbin/httpfs.sh status'
default['mapr']['warden']['httpfs']['config']['service.port'] = 14_000
default['mapr']['warden']['httpfs']['config']['service.ui.port'] = 14_000
default['mapr']['warden']['httpfs']['config']['service.uri'] = 'webhdfs/v1'
default['mapr']['warden']['httpfs']['config']['service.logs.location'] = '/opt/mapr/httpfs/httpfs-1.0/logs'
default['mapr']['warden']['httpfs']['config']['service.process.type'] = 'JAVA'
default['mapr']['warden']['httpfs']['config']['service.env'] = '"MAPR_MAPREDUCE_MODE=default"'