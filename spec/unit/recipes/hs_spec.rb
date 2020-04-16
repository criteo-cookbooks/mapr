# Cookbook Name:: mapr
# Spec:: cldb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::hs' do
  context 'When all attributes are default, on centos 7.6.1810' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.6.1810',
      ).converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should include the default recipe' do
      expect(chef_run).to include_recipe('mapr')
    end
    it 'installs mapr cldb package' do
      expect(chef_run).to upgrade_package('mapr-historyserver')
    end

    it 'should include the mapr::config recipe' do
      expect(chef_run).to include_recipe('mapr::config')
    end
  end
end
