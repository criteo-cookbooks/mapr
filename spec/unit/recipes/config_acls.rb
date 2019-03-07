# Copyright:: 2018, Criteo, All Rights Reserved.

require 'spec_helper'

describe 'mapr::config_acls' do
  let(:users) { ['fred', 'jane' ] }
  context 'Two users should have acls' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform:  'centos',
        version:   '7.4.1708',
      ) do |node|
        users.each do |u|
          node.default['mapr']['config']['acls']['user'][u] = 'fc2'
          node.default['mapr']['config']['acls']['user'][u] = 'fc2'
        end
        node.default['mapr']['config']['acls']['ignored']['lake'] = 'fc'
        node.override['mapr']['config']['owner'] = 'alice'
      end.converge(described_recipe)
    end

    before do
      users.each do |u|
        expect(Mixlib::ShellOut).to receive(:new)
          .with("/opt/mapr/bin/maprcli acl show -type cluster -user #{u}")
          .and_return(double(run_command: nil, stdout: acls, error!: nil))
      end
    end

    context 'no acls present' do
      let(:acls) { '' }

      it 'sets acl for all users' do
        users.each do |u|
          expect(chef_run).to run_execute("set acl for user #{u}")
            .with(command: "/opt/mapr/bin/maprcli acl edit -type cluster -user #{u}:fc2", user: 'alice')
        end
      end
    end

    context 'existing acls' do
      let(:acls) { "Allowed actions         Principal\n[login, ss, cv, a, fc]  User mapr\n" }

      it 'does not set any acls' do
        users.each do |u|
          expect(chef_run).to_not run_execute("set acl for user #{u}")
        end
      end
    end
  end
end
