# Cookbook Name:: mapr
# Spec:: config
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::config' do
  let(:mapr_clusters) { '/opt/mapr/conf/mapr-clusters.conf' }
  context 'Mapr Config without Kerberos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform:  'centos',
        version:   '7.4.1708',
        step_into: %w[mapr_configure_sh],
      ).converge(described_recipe)
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should generate the mapr-clusters.conf diabling the security' do
      expect(chef_run).to create_template(mapr_clusters)
        .with_variables(config: {
                          'cldbs' => 'cldb1:7222 cldb2:7222',
                          'name' => 'mapr.cluster.com',
                          'security' => {
                            'cldbPrincipal' => '',
                            'kerberosEnable' => false,
                            'secure' => false,
                          },
                        },)
    end

    it 'should not include recipe mapr::security' do
      expect(chef_run).to_not include_recipe('mapr::security')
    end
  end

  context 'MapR Config with Security but without Kerberos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.4.1708',
      ) do |node|
        node.override['mapr']['cluster']['config']['security']['secure'] = true
      end.converge(described_recipe)
    end
    it 'should include the mapr::security recipe' do
      expect(chef_run).to include_recipe('mapr::security')
    end
    it 'should create the mapr-clusters.conf with secure activated' do
      expect(chef_run).to create_template(mapr_clusters)
        .with_variables(config: {
                          'cldbs' => 'cldb1:7222 cldb2:7222',
                          'name' => 'mapr.cluster.com',
                          'security' => {
                            'cldbPrincipal' => '',
                            'kerberosEnable' => false,
                            'secure' => true,
                          },
                        },)
    end
  end

  context 'Mapr Config with Kerberos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.override['mapr']['cluster']['config']['security']['secure'] = true
        node.override['mapr']['cluster']['config']['security']['kerberosEnable'] = true
        node.override['mapr']['cluster']['config']['security']['kerberosEnable'] = true
        node.override['mapr']['cluster']['config']['security']['cldbPrincipal'] = 'mapr/mapr.cluster.com'
      end.converge(described_recipe)
    end
    it 'should generate mapr-clusters.conf with kerberos configuration' do
      expect(chef_run).to create_template(mapr_clusters)
        .with_variables(config: {
                          'cldbs' => 'cldb1:7222 cldb2:7222',
                          'name' => 'mapr.cluster.com',
                          'security' => {
                            'cldbPrincipal' => 'mapr/mapr.cluster.com',
                            'kerberosEnable' => true,
                            'secure' => true,
                          },
                        },)
    end
  end
end
