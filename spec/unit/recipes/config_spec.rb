# Cookbook Name:: mapr
# Spec:: config
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::config' do
  context 'When all attributes are default, on centos 7.4.1708' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        platform:  'centos',
        version:   '7.4.1708',
        step_into: %w[mapr_configure_sh],
      ) do |node|
        node.override['mapr']['platform']['cldb_hosts'] = %w[host1 host2]
        node.override['mapr']['platform']['zookeeper_hosts'] = %w[host3 host4]
        node.override['mapr']['cluster_name'] = 'test_cluster'
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'execute configure.sh' do
      expect(chef_run).to run_execute('MapR Initialization')
        .with(command: '/opt/mapr/server/configure.sh -C host1,host2 -N test_cluster -Z host3,host4 -g mapr -u mapr')
    end
  end
end
