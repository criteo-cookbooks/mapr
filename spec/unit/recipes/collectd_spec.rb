# Cookbook Name:: mapr
# Spec:: collectd
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::collectd' do
  context 'When all attributes are default, on centos 7.7.1908' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.7.1908',
      )
      runner.converge(described_recipe)
    end

    it 'should include the default recipe' do
      expect(chef_run).to include_recipe('mapr')
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'installs mapr collectd package' do
      expect(chef_run).to upgrade_package('mapr-collectd')
    end
  end
end
