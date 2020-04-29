# Cookbook Name:: mapr
# Spec:: mfs
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::hadoop' do
  let(:hadoop_path) { '/opt/mapr/hadoop/hadoop-2.7.0/etc/hadoop' }
  context 'When all attributes are default, on centos 7.7.1908' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new platform: 'centos', version: '7.7.1908' do |node|
        node.override['mapr']['hadoop']['config'] = {
          'core' => { 'property' => 'value' },
          'hdfs' => { 'property' => 'value' },
          'yarn' => { 'property' => 'value' },
        }
      end.converge(described_recipe)
    end
    it 'should generate the core-site.xml file' do
      expect(chef_run).to create_template(File.join(hadoop_path, 'core-site.xml'))
        .with_variables(config: { 'property' => 'value' })
    end

    it 'should generate the hdfs-site.xml' do
      expect(chef_run).to create_template(File.join(hadoop_path, 'hdfs-site.xml'))
        .with_variables(config: { 'property' => 'value' })
    end

    it 'shoould generate the yarn-site.xml' do
      expect(chef_run).to create_template(File.join(hadoop_path, 'yarn-site.xml'))
        .with_variables(config: { 'property' => 'value' })
    end
  end
end
