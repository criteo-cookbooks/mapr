# This file is auto-generated by the code_generator (one-time action)
#
# Cookbook Name:: mapr
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::default' do
  context 'When all attributes are default, on centos 7.6.1810' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.6.1810',
      ).converge(described_recipe)
    end

    it 'should include fundamental recipes' do
      %w[mapr::warden mapr::repositories mapr::core].each do |recipe|
        expect(chef_run).to include_recipe(recipe)
      end
    end

    it 'should create the mapr user & group' do
      expect(chef_run).to create_group('mapr')
      expect(chef_run).to create_user('mapr').with_group('mapr')
    end
  end
end
