module Mapr
  require 'json'
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

  class AttributeMerger < Hash
    "" " Merge two arrays if a predicate is true " ""

    def merge(predicate, h1, force = false)
      raise "the predicate should be of type: boolean, not: #{predicate.class.name}" unless predicate == !!predicate
      super.merge(h1) if predicate && !force
      super.merge!(h1) if predicate && force
    end
  end

  class NodeType
    "
    Deduct the node type from it's components
"
    @@components = Chef.node['mapr']['cluster']['components']
    class << self
      def empty?
        return @@components.nil? || @@components.empty?
      end

      def resourcemanager?
        include_services?('resourcemanager')
      end

      def storage?
        include_services?('storage')
      end

      def compute?
        include_services?('compute')
      end

      def cldb?
        include_services?('cldb')
      end

      def zookeeper?
        include_services?('zookeeper')
      end

      def mcs?
        include_services?('mcs')
      end

      def nfs?
        include_services?('nfs')
      end

      def grafana?
        include_services?('grafana')
      end

      def hs?
        include_services?('hs')
      end


      def mg?
        include_services?('mg')
      end

      private

      def include_services?(*elements)
        return false if empty?
        elements.map {|service| @@components.include?(service)}.all?
      end
    end
  end

  class KerberosUtil
    class << self
      def keytab_valid?(_keytab_path)
        cmd = ['k5start', '-U', '-f', new_resource.keytab, '--', 'kinit']
        executor Mixlib::ShellOut.new(*cmd)
        result = executor.run_command
        if executor.error?
          false
        else
          true
        end
      end
    end
  end
end
