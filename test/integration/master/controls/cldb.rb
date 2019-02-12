control 'master-packages' do
  impact 1
  desc '
  Ascertain all the necessary packages have been installed &
  correctly configured
'

  describe service('mapr-warden') do
    it { should be_installed }
    it { should be_enabled }
  end

  describe service('mapr-cldb') do
    it { should be_installed }
  end

  describe service('mapr-zookeeper') do
    it { should be_installed }
  end
  describe file('/opt/mapr/conf/cldb.conf') do
    its('owner') { should cmp 'mapr' }
    its('content') { should cmp inspec.profile.file('cldb.conf') }
    its('group') { should cmp 'mapr' }
    its('mode') { should cmp '0444' }
    it { should be_file }
  end

  describe file('/opt/mapr/zookeeper/zookeeperversion') do
    its('content') { should cmp '3.4.5' }
    its('owner') { should cmp 'mapr' }
    its('group') { should cmp 'mapr' }
  end

  describe file('/opt/mapr/zkdata/myid') do
    its('content') { should cmp '0' }
    its('owner') { should cmp 'mapr' }
    its('group') { should cmp 'mapr' }
  end
  describe file('/opt/mapr/conf/daemon.conf') do
    its('content') { should cmp inspec.profile.file('daemon.conf') }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'mapr' }
  end
  describe file('/opt/mapr/conf/mapr.login.conf') do
    # TODO: Enhance the matching, to be able to detect the maximum possible
    its('content') { should match(%r{.*"mapr\/mapr.cluster.com}) }
    its('owner') { should cmp 'mapr' }
    its('group') { should cmp 'mapr' }
  end
end

control 'master-config-without-security' do
  impact 1
  desc 'Ascertain mapr is correctly configured'

  # Check that finally we do have the appropriate roles
  describe command('ls -A /opt/mapr/roles').stdout.split do
    it { should cmp %w[apiserver cldb fileserver zookeeper] }
  end

  describe file('/opt/mapr/zookeeper/zookeeper-3.4.5/conf/zoo.cfg') do
    its('content') { should cmp inspec.profile.file('zoo.cfg') }
    its('owner') { should cmp 'mapr' }
    its('group') { should cmp 'mapr' }
    its('mode') { should cmp '0444' }
    it { should be_file }
  end

  describe file('/opt/mapr/conf/mapr-clusters.conf') do
    its('content') { should cmp inspec.profile.file('mapr-clusters.conf') }
    its('owner') { should cmp 'mapr' }
    its('group') { should cmp 'mapr' }
  end

  describe file('/opt/mapr/conf/warden.conf') do
    its('content') { should cmp inspec.profile.file('warden.conf') }
    its('owner') { should cmp 'mapr' }
    its('group') { should cmp 'mapr' }
    its('mode') { should cmp '0444' }
    it { should be_file }
  end
end
