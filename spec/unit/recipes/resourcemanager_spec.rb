# Cookbook Name:: mapr
# Spec:: resourcemanager
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::resourcemanager' do
  context 'When all attributes are default, on centos 7.6.1810' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.6.1810',
      )
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'installs mapr resourcemanager package' do
      expect(chef_run).to upgrade_package('mapr-resourcemanager')
    end

    it 'should include the recipe default' do
      expect(chef_run).to include_recipe('mapr')
    end
  end
end
