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
        version:  '7.7.1908',
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
          mode:      0o644,
          variables: {
            config: {
              'centralconfig.enabled' => true,
              'hoststats.port' => 5660,
              'hs.host' => 'localhost',
              'hs.port' => 1111,
              'hs.rpcon' => true,
              'isDB' => true,
              'isM7' => 0,
              'log.retention.exceptions' => 'cldbaudit*,authaudit*,cldb*.log,hoststats.log,configure.log,mfs.log-*,nfsserver.log*',
              'mapr.home.dir' => '/opt/mapr',
              'nodes.mincount' => 1,
              'pollcentralconfig.interval.seconds' => 300,
              'rpc.drop' => false,
              'service.command.hoststats.monitorcommand' => '/opt/mapr/initscripts/mapr-hoststats status',
              'service.command.hoststats.start' => '/opt/mapr/initscripts/mapr-hoststats start',
              'service.command.hoststats.stop' => '/opt/mapr/initscripts/mapr-hoststats stop',
              'service.command.hoststats.type' => 'BACKGROUND',
              'service.command.kvstore.monitor' => 'server/mfs',
              'service.command.kvstore.monitorcommand' => '/opt/mapr/initscripts/mapr-mfs status',
              'service.command.kvstore.start' => '/opt/mapr/initscripts/mapr-mfs start',
              'service.command.kvstore.stop' => '/opt/mapr/initscripts/mapr-mfs stop',
              'service.command.kvstore.type' => 'BACKGROUND',
              'service.command.os.heapsize.max' => 4000,
              'service.command.os.heapsize.min' => 256,
              'service.command.os.heapsize.percent' => 10,
              'service.command.warden.heapsize.max' => 750,
              'service.command.warden.heapsize.min' => 64,
              'service.command.warden.heapsize.percent' => 1,
              'service.command.zk.heapsize.max' => 1500,
              'service.command.zk.heapsize.min' => 256,
              'service.command.zk.heapsize.percent' => 1,
              'service.nice.value' => -10,
              'services' => 'kvstore:all;hoststats:all:kvstore',
              'services.memoryallocation.alarm.threshold' => 97,
              'services.retries' => 3,
              'services.retryinterval.time.sec' => 1800,
              'zookeeper.servers' => 'zk1:5181,zk2:5181,zk3:5181',
            },
          },
        )
    end
    it 'should create the warden systemd unit file' do
      expect(chef_run).to render_file('/etc/systemd/system/mapr-warden.service').with_content(/User=mapr/)
    end
  end
end
