# Cookbook Name:: mapr
# Spec:: compute
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::compute' do
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
    it 'installs required compute packages' do
      expect(chef_run).to install_package(%w[
                                            mapr-mapreduce2
                                            mapr-nodemanager
                                          ],)
    end
  end
end
