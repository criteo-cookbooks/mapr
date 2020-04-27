# Cookbook Name:: mapr
# Spec:: mfs
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::mfs' do
  context 'When all attributes are default, on centos 7.7.1908' do
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
    it 'installs mapr mfs package' do
      expect(chef_run).to upgrade_package('mapr-fileserver')
    end
    it 'should include the recipe mapr::config' do
      expect(chef_run).to include_recipe('mapr::config')
    end

    it 'should include the recipe default' do
      expect(chef_run).to include_recipe('mapr')
    end

    it 'should include the disks recipe' do
      expect(chef_run).to include_recipe('mapr::disks')
    end

    it 'should include the hadoop recipe' do
      expect(chef_run).to include_recipe('mapr::hadoop')
    end
  end
end
