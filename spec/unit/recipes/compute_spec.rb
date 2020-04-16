# Cookbook Name:: mapr
# Spec:: compute
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::compute' do
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
    it 'installs required compute packages' do
      expect(chef_run).to upgrade_package(%w[
                                            mapr-mapreduce2
                                            mapr-nodemanager
                                          ],)
    end
    it 'should include the mapr::config recipe' do
      expect(chef_run).to include_recipe('mapr::config')
    end

    it 'should include the default recipe' do
      expect(chef_run).to include_recipe('mapr')
    end
  end
end
