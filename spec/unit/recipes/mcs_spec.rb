# Cookbook Name:: mapr
# Spec:: mcs
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::mcs' do
  context 'When all attributes are default, on centos 7.7.1908' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.7.1908',
      )
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'installs mapr mcs package' do
      expect(chef_run).to upgrade_package('mapr-webserver')
    end
    it 'should include the mapr::config recipe' do
      expect(chef_run).to include_recipe('mapr::config')
    end

    it 'should include the recipe default' do
      expect(chef_run).to include_recipe('mapr')
    end

    it 'creates apiserver tmp directory with correct permissions' do
      expect(chef_run).to create_directory('/opt/mapr/apiserver/tmp').with(
        owner: 'mapr',
        group: 'mapr',
        mode:  0o755,
      )
    end

    it 'creates apiserver PID file with correct permissions' do
      expect(chef_run).to create_file('/opt/mapr/apiserver/conf/apiserver.pid').with(
        owner: 'mapr',
        group: 'mapr',
        mode:  0o644,
      )
    end

    it 'configure the api server' do
      expect(chef_run).to create_template('/opt/mapr/apiserver/conf/properties.cfg')
        .with_variables(
          config: {
            'doc.url' => 'https://maprdocs.mapr.com',
            'mapr.webui.https.port' => 8443,
            'ojai.cache.size' => 64,
            'proxy.zkservices' => 'elasticsearch, opentsdb',
          },
        )
    end

    it 'creates log directory with correct permissions' do
      expect(chef_run).to create_directory('/opt/mapr/apiserver/logs').with(
        owner: 'mapr',
        group: 'mapr',
        mode:  0o755,
      )
    end
  end
end
