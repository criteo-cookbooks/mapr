# Cookbook Name:: mapr
# Spec:: zookeeper
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::warden' do
  context 'Configure Warden' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.4.1708',
      )
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'puts in place the correct configuration' do
      expect(chef_run).to create_template('/opt/mapr/conf/warden.conf')
        .with(
          owner:     'mapr',
          group:     'mapr',
          mode:      0o400,
          variables: {
            config: {
              'service.command.cldb.heapsize.max' => 4000,
              'service.command.mfs.heapsize.min' => 512,
              'service.command.mfs.heapsize.percent' => 35,
              'centralconfig.enabled' => true,
              'cldb.port' => 7222,
              'hoststats.port' => 5660,
              'hs.host' => 'localhost',
              'hs.port' => 1111,
              'hs.rpcon' => true,
              'isDB' => true,
              'isM7' => 0,
              'kvstore.port' => 5660,
              'log.retention.exceptions' => 'cldbaudit*,authaudit*,cldb*.log,hoststats.log,configure.log,mfs.log-*,nfsserver.log*',
              'mapr.home.dir' => '/opt/mapr',
              'mfs.port' => 5660,
              'nodes.mincount' => 1,
              'pollcentralconfig.interval.seconds' => 300,
              'rpc.drop' => false,
              'service.command.cldb.heapsize.min' => 256,
              'service.command.cldb.heapsize.percent' => 8,
              'service.command.cldb.monitor' => 'com.mapr.fs.cldb.CLDB',
              'service.command.cldb.monitorcommand' => '/opt/mapr/initscripts/mapr-cldb status',
              'service.command.cldb.retryinterval.time.sec' => 600,
              'service.command.cldb.start' => '/opt/mapr/initscripts/mapr-cldb start',
              'service.command.cldb.stop' => '/opt/mapr/initscripts/mapr-cldb stop',
              'service.command.cldb.type' => 'BACKGROUND',
              'service.command.hoststats.monitorcommand' => '/opt/mapr/initscripts/mapr-hoststats status',
              'service.command.hoststats.start' => '/opt/mapr/initscripts/mapr-hoststats start',
              'service.command.hoststats.stop' => '/opt/mapr/initscripts/mapr-hoststats stop',
              'service.command.hoststats.type' => 'BACKGROUND',
              'service.command.kvstore.monitor' => 'server/mfs',
              'service.command.kvstore.monitorcommand' => '/opt/mapr/initscripts/mapr-mfs status',
              'service.command.kvstore.start' => '/opt/mapr/initscripts/mapr-mfs start',
              'service.command.kvstore.stop' => '/opt/mapr/initscripts/mapr-mfs stop',
              'service.command.kvstore.type' => 'BACKGROUND',
              'service.command.mfs.heapsize.maxpercent' => 85,
              'service.command.mfs.monitor' => 'server/mfs',
              'service.command.mfs.monitorcommand' => '/opt/mapr/initscripts/mapr-mfs status',
              'service.command.mfs.start' => '/opt/mapr/initscripts/mapr-mfs start',
              'service.command.mfs.stop' => '/opt/mapr/initscripts/mapr-mfs stop',
              'service.command.mfs.type' => 'BACKGROUND',
              'service.command.nfs.heapsize.max' => 1000,
              'service.command.nfs.heapsize.min' => 64,
              'service.command.nfs.heapsize.percent' => 3,
              'service.command.nfs.monitor' => 'server/nfsserver',
              'service.command.nfs.monitorcommand' => '/opt/mapr/initscripts/mapr-nfsserver status',
              'service.command.nfs.start' => '/opt/mapr/initscripts/mapr-nfsserver start',
              'service.command.nfs.stop' => '/opt/mapr/initscripts/mapr-nfsserver stop',
              'service.command.nfs.type' => 'BACKGROUND',
              'service.command.nfs4.heapsize.max' => 1000,
              'service.command.nfs4.heapsize.min' => 64,
              'service.command.nfs4.heapsize.percent' => 3,
              'service.command.nfs4.monitor' => 'bin/nfs4server',
              'service.command.nfs4.monitorcommand' => '/opt/mapr/initscripts/mapr-nfs4server status',
              'service.command.nfs4.start' => '/opt/mapr/initscripts/mapr-nfs4server start',
              'service.command.nfs4.stop' => '/opt/mapr/initscripts/mapr-nfs4server stop',
              'service.command.nfs4.type' => 'BACKGROUND',
              'service.command.os.heapsize.max' => 4000,
              'service.command.os.heapsize.min' => 256,
              'service.command.os.heapsize.percent' => 10,
              'service.command.warden.heapsize.max' => 750,
              'service.command.warden.heapsize.min' => 64,
              'service.command.warden.heapsize.percent' => 1,
              'service.command.webserver.heapsize.max' => 750,
              'service.command.webserver.heapsize.min' => 512,
              'service.command.webserver.heapsize.percent' => 3,
              'service.command.webserver.monitorcommand' => '/opt/mapr/adminuiapp/webserver status',
              'service.command.webserver.start' => '/opt/mapr/adminuiapp/webserver start',
              'service.command.webserver.stop' => '/opt/mapr/adminuiapp/webserver stop',
              'service.command.webserver.type' => 'BACKGROUND',
              'service.command.zk.heapsize.max' => 1500,
              'service.command.zk.heapsize.min' => 256,
              'service.command.zk.heapsize.percent' => 1,
              'service.nice.value' => -10,
              'services' => 'nfs:all:cldb;kvstore:all;cldb:all:kvstore;hoststats:all:kvstore',
              'services.memoryallocation.alarm.threshold' => 97,
              'services.retries' => 3,
              'services.retryinterval.time.sec' => 1800,
              'zookeeper.servers' => 'zk1,zk2',
            },
          },
        )
    end
  end
end
