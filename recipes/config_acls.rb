['user', 'group'].each do |what|
  node['mapr']['config'].fetch('acls', {}).fetch(what, {}).each do |who, perms|
    execute "set acl for #{what} #{who}" do
      command "/opt/mapr/bin/maprcli acl edit -type cluster -#{what} #{who}:#{perms}"
      user node['mapr']['config']['owner']
      only_if do
        Mixlib::ShellOut.new("/opt/mapr/bin/maprcli acl show -type cluster -#{what} #{who}").tap do |command|
          command.run_command
          command.error!
        end.stdout.empty?
      end
    end
  end
end
