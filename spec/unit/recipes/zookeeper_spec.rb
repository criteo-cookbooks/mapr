# Cookbook Name:: mapr
# Spec:: zookeeper
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

# rubocop: disable BlockLength
describe 'mapr::zookeeper' do
  context 'Install & Configure Zookeeper with SIMPLE Security' do
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

    it 'sets the correct zookeeper version' do
      expect(chef_run).to create_file('/opt/mapr/zookeeper/zookeeperversion')
        .with(
          content: '3.4.5',
          owner:   'mapr',
          group:   'mapr',
        )
    end
    it 'creates zookeeper data directory' do
      expect(chef_run).to create_directory('/opt/mapr/zkdata').with(
        owner:     'mapr',
        group:     'mapr',
        recursive: true,
      )
    end
    it 'installs mapr zookeeper package' do
      expect(chef_run).to upgrade_package('mapr-zookeeper')
    end
    it 'should configure zookeeper' do
      expect(chef_run).to create_template('/opt/mapr/zookeeper/zookeeper-3.4.5/conf/zoo.cfg')
        .with_variables(config: {
                          'authMech' => 'SIMPLE-SECURITY',
                          'authProvider.1' => 'org.apache.zookeeper.server.auth.SASLAuthenticationProvider',
                          'autopurge.purgeInterval' => 24,
                          'clientPort' => 5181,
                          'dataDir' => '/opt/mapr/zkdata',
                          'initLimit' => 20,
                          'mapr.cldbkeyfile.location' => '/opt/mapr/conf/cldb.key',
                          'mapr.usemaprserverticket' => true,
                          'maxClientCnxns' => 1000,
                          'readUser' => 'anyone',
                          'server.0' => 'zk1:2888:3888',
                          'server.1' => 'zk2:2888:3888',
                          'server.2' => 'zk3:2888:3888',
                          'superUser' => 'mapr',
                          'syncLimit' => 10,
                          'tickTime' => 2000,
                        },)
    end

    it 'should include the recipe default' do
      expect(chef_run).to include_recipe('mapr')
    end
  end
  context 'When security is enabled' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.4.1708',
      ) do |node|
        node.override['mapr']['cluster']['config']['security']['secure'] = true
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates zookeeper data directory' do
      expect(chef_run).to create_directory('/opt/mapr/zkdata').with(
        owner:     'mapr',
        group:     'mapr',
        recursive: true,
      )
    end
    it 'installs mapr zookeeper package' do
      expect(chef_run).to upgrade_package('mapr-zookeeper')
    end
    it 'should configure zookeeper' do
      expect(chef_run).to create_template('/opt/mapr/zookeeper/zookeeper-3.4.5/conf/zoo.cfg')
        .with(
          owner:     'mapr',
          group:     'mapr',
          mode:      0o644,
          variables: {
            config: {
              'authMech' => 'MAPR-SECURITY',
              'authProvider.1' => 'org.apache.zookeeper.server.auth.SASLAuthenticationProvider',
              'autopurge.purgeInterval' => 24,
              'clientPort' => 5181,
              'dataDir' => '/opt/mapr/zkdata',
              'initLimit' => 20,
              'mapr.cldbkeyfile.location' => '/opt/mapr/conf/cldb.key',
              'mapr.usemaprserverticket' => true,
              'maxClientCnxns' => 1000,
              'quorum.auth.enableSasl' => true,
              'quorum.auth.learner.saslLoginContext' => 'Server',
              'quorum.auth.learnerRequireSasl' => true,
              'quorum.auth.server.saslLoginContext' => 'Server',
              'quorum.auth.serverRequireSasl' => true,
              'quorum.cnxn.threads.size' => 20,
              'readUser' => 'anyone',
              'server.0' => 'zk1:2888:3888',
              'server.1' => 'zk2:2888:3888',
              'server.2' => 'zk3:2888:3888',
              'superUser' => 'mapr',
              'syncLimit' => 10,
              'tickTime' => 2000,
            },
          },
        )
    end

    it 'should include the recipe default' do
      expect(chef_run).to include_recipe('mapr')
    end
  end
end
# rubocop: enable BlockLength
