# Cookbook Name:: mapr
# Spec:: users
#
# Copyright:: 2019, Criteo, All Rights Reserved.

require 'spec_helper'

describe 'mapr::default' do
  context 'With default attributes, on centos 7.6.1810' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.6.1810',
      ).converge(described_recipe)
    end

    it 'should create the mapr user & group' do
      expect(chef_run).to create_group('mapr')
      expect(chef_run).to create_user('mapr').with_group('mapr')
    end
  end
end
