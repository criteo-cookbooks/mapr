# Cookbook Name:: mapr
# Spec:: zookeeper
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::zookeeper' do
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

    it 'creates zookeeper data directory' do
      expect(chef_run).to create_directory('/opt/mapr/zkdata')
    end
    it 'installs mapr zookeeper package' do
      expect(chef_run).to install_package('mapr-zookeeper')
    end
  end
end
