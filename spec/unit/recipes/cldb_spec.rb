# Cookbook Name:: mapr
# Spec:: cldb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::cldb' do
  context 'When all attributes are default, on centos 7.7.1908' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.7.1908',
      ).converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should include the default recipe' do
      expect(chef_run).to include_recipe('mapr')
    end
    it 'installs mapr cldb package' do
      expect(chef_run).to upgrade_package('mapr-cldb')
    end

    it 'should configure the cldb' do
      expect(chef_run).to create_template('/opt/mapr/conf/cldb.conf')
        .with_variables(
          config: {
            'cldb.containers.cache.entries' => 1_000_000,
            'cldb.containers.cache.percent' => 20,
            'cldb.default.topology' => '',
            'cldb.detect.dup.hostid.enabled' => false,
            'cldb.jmxremote.port' => 7220,
            'cldb.min.fileservers' => 1,
            'cldb.numthreads' => 10,
            'cldb.port' => 7222,
            'cldb.web.https.port' => 0,
            'cldb.web.port' => 7221,
            'cldb.zookeeper.servers' => 'zk1:5181,zk2:5181,zk3:5181',
            'enable.replicas.invariant.check' => false,
            'hadoop.version' => '2.7.0',
            'net.topology.table.file.name' => '/home/mapr/topo.pl',
            'num.volmirror.threads' => 1,
          },
        )
    end

    it 'should include the mapr::config recipe' do
      expect(chef_run).to include_recipe('mapr::config')
    end
  end

  context 'Secure mode (Not necessarily with Kerberos)' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new platform: 'centos', version: '7.7.1908' do |node|
        node.override['mapr']['cluster']['config']['security']['secure'] = true
      end.converge(described_recipe)
    end

    it 'must include mapr::security recipe' do
      expect(chef_run).to include_recipe('mapr::security')
    end
  end
end
