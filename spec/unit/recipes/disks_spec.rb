# Cookbook Name:: mapr
# Spec:: disks
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::disks' do
  context 'When all attributes are default, on centos 7.7.1908' do
    let(:disk0) { '/dev/disk/by-id/wwn-0x12345678' }
    let(:disk2) { '/dev/disk/by-id/wwn-0x02346578' }
    let(:disk3) { '/dev/disk/by-id/wwn-0x00346578' }
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        platform:  'centos',
        version:   '7.7.1908',
        step_into: %w[mapr_disksetup],
      ) do |node|
        ['a', 'b', 'r', 'z', 'y', 't'].each do |t|
          node.override['block_device']["sd#{t}"]['state'] = t == 'y' ? 'dead' : 'running'
          node.override['block_device']["sd#{t}"]['removable'] = '0'
        end
      end
      runner.converge(described_recipe)
    end

    before do
      disk1 = '/dev/disk/by-id/wwn-0x12345eff'
      disk4 = '/dev/disk/by-id/wwn-0x5000c500921464d9'
      disk5 = '/dev/disk/by-id/wwn-0x50005c00921464d9'

      allow(::Dir).to receive(:glob).and_call_original
      wwns = [disk4, disk0, disk3, disk1, "#{disk1}-part1", "#{disk1}-part2", disk2]
      allow(::Dir).to receive(:glob).with(['/dev/disk/by-id/wwn-*']).and_return wwns

      allow(::File).to receive(:readlink).and_call_original
      allow(::File).to receive(:readlink).with(disk0).and_return '../../sdz'
      allow(::File).to receive(:readlink).with(disk2).and_return '../../sdr'
      allow(::File).to receive(:readlink).with(disk1).and_return '../../sdt'
      allow(::File).to receive(:readlink).with(disk3).and_return '../../sdb'
      allow(::File).to receive(:readlink).with(disk4).and_return '../../sda'
      allow(::File).to receive(:readlink).with(disk5).and_return '../../sdy'
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'create diskfile' do
      expect(chef_run).to render_file('/tmp/disksetup_configure_new_disks.txt')
        .with_content("#{disk3}\n#{disk2}\n#{disk0}\n")
    end
    it 'execute disksetup' do
      expect(chef_run).to run_execute('MapR disksetup configure new disks')
        .with(command: '/opt/mapr/server/disksetup -W 1 -F /tmp/disksetup_configure_new_disks.txt')
    end
    it 'should execute the mapr request' do
      # TODO: Finish with the mapr version
      expect(chef_run).to run_mapr_disksetup('configure new disks')
    end
  end
end
