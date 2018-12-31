require 'spec_helper'

describe 'mapr::security' do
  let(:config_dir) { '/opt/mapr/conf' }
  context 'Secure mode activated in a storage node' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version:  '7.4.1708',
      ).converge(described_recipe)
    end
    it 'should create the ssl files' do
      expect(chef_run).to render_file(File.join(config_dir, 'ssl_truststore.pem')).with_content('KEY_CONTENT')
      expect(chef_run).to render_file(File.join(config_dir, 'ssl_truststore')).with_content('KEY_CONTENT')
      expect(chef_run).to render_file(File.join(config_dir, 'ssl_truststore.p12')).with_content('KEY_CONTENT')
      expect(chef_run).to render_file(File.join(config_dir, 'ssl_keystore.pem')).with_content('KEY_CONTENT')
      expect(chef_run).to render_file(File.join(config_dir, 'ssl_keystore')).with_content('KEY_CONTENT')
      expect(chef_run).to render_file(File.join(config_dir, 'ssl_keystore.p12')).with_content('KEY_CONTENT')
    end

    it 'should not create the cldb.key' do
      expect(chef_run).to_not render_file(File.join(config_dir, 'cldb.key')).with_content('Test')
    end

    it 'should generate the maprserverticket' do
      expect(chef_run).to create_template(File.join(config_dir, 'maprserverticket'))
        .with_variables(
          cluster_name: 'mapr.cluster.com',
          secret:       'KEY_CONTENT',
        )
    end
  end

  context 'Secure mode in a master node' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new platform: 'centos', version: '7.4.1708' do |node|
        node.override['mapr']['cluster']['components'] = %w[cldb]
        node.override['mapr']['cluster']['config']['security']['secure'] = true
      end.converge(described_recipe)
    end
    it 'should generate the cldb.key' do
      expect(chef_run).to create_file(File.join(config_dir, 'cldb.key')).with_content('KEY_CONTENT')
    end
  end
end
