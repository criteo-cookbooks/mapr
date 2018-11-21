# Cookbook Name:: mapr
# Spec:: mcs
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::mcs' do
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
    it 'installs mapr mcs package' do
      expect(chef_run).to upgrade_package('mapr-webserver')
    end
    it 'should include the mapr::config recipe' do
      expect(chef_run).to include_recipe('mapr::config')
    end

    it 'should include the recipe default' do
      expect(chef_run).to include_recipe('mapr')
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
  end
end
