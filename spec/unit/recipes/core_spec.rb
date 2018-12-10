# Cookbook Name:: mapr
# Spec:: core
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::core' do
  context 'When all attributes are default, on centos 7.4.1708' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.4.1708',
      ).converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs core packages' do
      expect(chef_run).to upgrade_package(%w[
                                            mapr-core
                                            mapr-core-internal
                                          ],)
    end
  end
end
