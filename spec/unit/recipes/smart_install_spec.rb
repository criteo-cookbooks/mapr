# Cookbook Name:: mapr
# Spec:: smart_install
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::smart_install' do
  context 'Install only cldb, zookeeper and resourcemanger' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.4.1708',
      ) do |node|
        node.override['mapr']['cluster']['components'] = %w[cldb resourcemanager zookeeper]
      end.converge(described_recipe)
    end

    it 'should inlcude the correct recipes to install the cluster' do
      expect(chef_run).to include_recipe('mapr::cldb')
      expect(chef_run).to include_recipe('mapr::resourcemanager')
      expect(chef_run).to include_recipe('mapr::zookeeper')
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'should not include other services recipe' do
      expect(chef_run).to_not include_recipe('mapr::mcs')
      expect(chef_run).to_not include_recipe('mapr::nfs')
      expect(chef_run).to_not include_recipe('mapr::grafana')
      expect(chef_run).to_not include_recipe('mapr::compute')
      expect(chef_run).to_not include_recipe('mapr::storage')
      expect(chef_run).to_not include_recipe('mapr::jh')
    end
  end
end
