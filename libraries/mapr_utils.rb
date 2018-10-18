module Mapr
  # Module for configure.sh script
  module ConfigureSh
    module_function

    MAPR_CONFIGURE_SCRIPT = '/opt/mapr/server/configure.sh'.freeze unless const_defined?(:MAPR_CONFIGURE_SCRIPT)

    # Build the configure.sh command depending on args Hash
    # args Hash should in a { 'option' => value} format
    # Example : args = { '-N' => "cluster_name", '-C' => "host1,host2,host3", '-Z' => "host4,host5,host6" }
    # Options with no value are passed like { '-secure' => true }
    def build_command(args)
      cmd_string = MAPR_CONFIGURE_SCRIPT.dup
      args.sort.each do |a, v|
        # non-value options
        if v == true
          cmd_string << " #{a}"
          next
        end
        cmd_string << " #{a} #{v}"
      end
      cmd_string
    end
  end

  module DiskSetup
    module_function

    MAPR_DISKSETUP_SCRIPT = '/opt/mapr/server/disksetup'.freeze unless const_defined?(:MAPR_DISKSETUP_SCRIPT)
    MAPR_DISKSTAB_FILE = '/opt/mapr/conf/disktab'.freeze unless const_defined?(:MAPR_DISKSTAB_FILE)

    def configured_disks
      disks = []
      return disks unless File.exist?(MAPR_DISKSTAB_FILE)
      File.open(MAPR_DISKSTAB_FILE).each do |line|
        if line =~ %r{^\/dev}
          arr = line.split
          disks << arr[0]
        end
      end
      disks.sort
    end

    def build_command(opts, stripe_width, disks_file)
      cmd_string = MAPR_DISKSETUP_SCRIPT.dup
      if opts.include?('-W')
        raise 'DiskSetup : "-W" argument need a stripe_width value' unless stripe_width
        cmd_string << " -W #{stripe_width}"
        opts.delete('-W')
      end
      cmd_string << " #{opts.join(' ')}" << " #{disks_file}"
    end
  end
end
