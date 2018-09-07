# Cookbook Name:: mapr
# Spec:: prerequisite
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::prerequisites' do
  context 'When all attributes are default, on centos 7.4.1708' do
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
    it 'creates mapr group ' do
      expect(chef_run).to create_group('mapr')
    end
    it 'creates mapr user ' do
      expect(chef_run).to create_user('mapr')
    end

    it 'installs mapr cldb package' do
      expect(chef_run).to install_package(%w[
                                            MySQL-python
                                          ],)
    end
    it 'sets specific systcl parameters' do
      expect(chef_run).to apply_sysctl_param('vm.swappiness').with(
        value: '10',
      )
      expect(chef_run).to apply_sysctl_param('net.ipv4.tcp_retries2').with(
        value: '5',
      )
      expect(chef_run).to apply_sysctl_param('vm.overcommit_memory').with(
        value: '0',
      )
    end
  end
end
