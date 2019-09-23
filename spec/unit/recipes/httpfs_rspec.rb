require 'spec_helper'

describe 'mapr::httpfs' do
  context 'When all attributes are default, on centos 7.4.1708' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform:  'centos',
        version:   '7.4.1708',
        step_into: ['warden_service'],
        ).converge(described_recipe)
    end

    it 'installs mapr-httpfs package' do
      expect(chef_run).to upgrade_package('mapr-httpfs')
    end

    it 'should call warden_service resource for httpfs' do
      expect(chef_run).to create_warden_service('httpfs')
    end

    it 'should create httpfs warden service with 1 httpfs node' do
      expect(chef_run).to (render_file('/opt/mapr/conf/conf.d/warden.httpfs.conf').with_content do |content|
        expect(content).to match(/services=httpfs:1:cldb/)
        expect(content).to match(/service.port=14000/)
      end)
    end
  end
  context 'With 46 httpfs nodes' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform:  'centos',
        version:   '7.4.1708',
        step_into: ['warden_service'],
        ) do |node|
        node.override['mapr']['httpfs']['nb_servers']  = 46
      end.converge(described_recipe)
    end
    it 'should create httpfs warden service with 46 httpfs node' do
      expect(chef_run).to (render_file('/opt/mapr/conf/conf.d/warden.httpfs.conf').with_content do |content|
        expect(content).to match(/services=httpfs:46:cldb/)
      end)
    end
  end
end