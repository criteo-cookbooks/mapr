require 'spec_helper'

describe 'mapr::mast_gateway' do
  context 'When all attributes are default, on centos 7.7.1908' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform:  'centos',
        version:   '7.7.1908',
        step_into: ['warden_service'],
      ).converge(described_recipe)
    end

    it 'installs mapr-mastgateway package' do
      expect(chef_run).to upgrade_package('mapr-mastgateway')
    end

    it 'should call warden_service resource for mastgateway' do
      expect(chef_run).to create_warden_service('mastgateway')
    end

    it 'should create mastgateway warden service' do
      expect(chef_run).to (render_file('/opt/mapr/conf/conf.d/warden.mastgateway.conf').with_content do |content|
        expect(content).to match(/services=mastgateway:all:cldb/)
        expect(content).to match(/service.heapsize.max=20480/)
      end)
    end
  end
end
