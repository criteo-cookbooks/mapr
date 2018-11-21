# Resource properties
property :disks, Array, required: true
property :stripe_width, Integer
property :opts, Array

load_current_value do |_new_resource|
  configured_disks = ::Mapr::DiskSetup.configured_disks()
  if configured_disks
    disks configured_disks
  else
    current_value_does_not_exist!
  end
end

action :run do
  converge_if_changed(:disks) do
    name = new_resource.name
    disks = new_resource.disks
    opts = new_resource.opts
    stripe_width = new_resource.stripe_width

    # Create tmpfile containing disks list
    diskfile = ::File.join('/tmp/', "disksetup_#{name.gsub(/ /, '_')}.txt")
    file diskfile do
      content disks.join("\n")
    end
    cmd = ::Mapr::DiskSetup.build_command(opts, stripe_width, diskfile)

    execute "MapR disksetup #{name}" do
      command cmd
    end
  end
end
