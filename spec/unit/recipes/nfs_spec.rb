# Cookbook Name:: mapr
# Spec:: cfs
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mapr::nfs' do
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
    it 'installs required nfs packages' do
      expect(chef_run).to upgrade_package(%w[
                                            mapr-nfs
                                            nfs-utils
                                            rpcbind
                                          ],)
    end
    it 'creates /mapr directory' do
      expect(chef_run).to create_directory('/mapr')
    end

    it 'create mapr fstab file' do
      expect(chef_run).to render_file('/opt/mapr/conf/mapr_fstab')
        .with_content('nolock,nfsvers=3')
    end

    it 'should include the recipe mapr::config' do
      expect(chef_run).to include_recipe('mapr::config')
    end

    it 'should include the recipe default' do
      expect(chef_run).to include_recipe('mapr')
    end
  end
end
