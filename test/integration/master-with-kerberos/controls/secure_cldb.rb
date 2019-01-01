require_controls 'mapr-master' do
  control 'master-packages'
end

control 'secure-cldb' do
  title 'Secure MapR Cluster'

  describe file('/opt/mapr/conf/mapr-clusters.conf') do
    its('content') { should cmp inspec.profile.file('mapr-clusters.conf') }
    its('owner') { should cmp 'mapr' }
    its('group') { should cmp 'mapr' }
    its('mode') { should cmp '0444' }
  end

  describe file('/opt/mapr/conf/cldb.conf') do
    its('owner') { should cmp 'mapr' }
    its('group') { should cmp 'mapr' }
    its('mode') { should cmp '0444' }
    its('content') { should cmp inspec.profile.file('cldb.conf') }
  end

  describe file('/opt/mapr/conf/warden.conf') do
    its('content') { should cmp inspec.profile.file('warden.conf') }
    its('owner') { should cmp 'mapr' }
    its('group') { should cmp 'mapr' }
    its('mode') { should cmp '0444' }
  end

  describe file('/opt/mapr/conf/jmxremote.access') do
    its('content') { should cmp inspec.profile.file('jmxremote.access') }
  end

  describe file('/opt/mapr/conf/jmxremote.password') do
    its('content') { should cmp inspec.profile.file('jmxremote.password') }
  end

  describe file('/opt/mapr/zookeeper/zookeeper-3.4.5/conf/zoo.cfg') do
    its('content') { should cmp inspec.profile.file('zoo.cfg') }
    its('owner') { should cmp 'mapr' }
    its('group') { should cmp 'mapr' }
    its('mode') { should cmp '0444' }
    it { should be_file }
  end
end
