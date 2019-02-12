# Cookbook Name:: mapr
# Spec:: disks
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::disks' do
  context 'When all attributes are default, on centos 7.4.1708' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        platform:  'centos',
        version:   '7.4.1708',
        step_into: %w[mapr_disksetup],
      ) do |node|
        node.override['mapr']['mfs']['disks'] = %w[disk1 disk2 disk3]
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'create diskfile' do
      expect(chef_run).to render_file('/tmp/disksetup_format_all_disks.txt')
        .with_content("disk1\ndisk2\ndisk3")
    end
    it 'execute disksetup' do
      expect(chef_run).to run_execute('MapR disksetup format all disks')
        .with(command: '/opt/mapr/server/disksetup -W 1 -F /tmp/disksetup_format_all_disks.txt')
    end
    it 'should execute the mapr request' do
      # TODO: Finish with the mapr version
      expect(chef_run).to run_mapr_disksetup('format all disks')
    end
  end
end
