# Cookbook Name:: mapr
# Spec:: mfs
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::hadoop' do
  let(:hadoop_path) { '/opt/mapr/hadoop/hadoop-2.7.0/conf' }
  context 'When all attributes are default, on centos 7.4.1708' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.4.1708',
      )
      runner.converge(described_recipe)
    end
    it 'should generate the core-site.xml file' do
      expect(chef_run).to create_template(File.join(hadoop_path, 'core-site.xml'))
        .with_variables(config: {})
    end

    it 'should generate the hdfs-site.xml' do
      expect(chef_run).to create_template(File.join(hadoop_path, 'hdfs-site.xml'))
        .with_variables(config: {})
    end

    it 'shoould generate the yarn-site.xml' do
      expect(chef_run).to create_template(File.join(hadoop_path, 'yarn-site.xml'))
        .with_variables(config: {})
    end
  end
end
