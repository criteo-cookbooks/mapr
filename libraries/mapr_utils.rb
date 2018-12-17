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

  class AttributeMerger
    "" " Merge two arrays if a predicate is true " ""
    attr_reader :hash
    def initialize(hash)
      @hash = hash
    end

    def merge(predicate, h1, _force = false)
      raise "the predicate should be of type: boolean, not: #{predicate.class.name}" unless predicate == !!predicate
      @hash = @hash.merge(h1) if predicate && !_force
      @hash = @hash.merge!(h1) if predicate && _force
    end
  end

  class NodeType
    "
    Deduct the node type from it's components
"
    class << self
      def empty?
        components.nil? || components.empty?
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
        elements.map {|service| components.include?(service)}.all?
      end

      def components
        Chef.node['mapr']['cluster']['components']
      end
    end
  end

  class KerberosUtil
    class << self
      def keytab_valid?(_keytab_path)
        cmd = ['k5start', '-U', '-f', _keytab_path, '--', 'kinit']
        executor = Mixlib::ShellOut.new(*cmd)
        result = executor.run_command
        if executor.error?
          false
        else
          true
        end
      end

      def make_keytab(keytab, kvno, principal, enclist, password)
        tmp = "#{keytab}.tmp"
        begin
          File.delete(tmp)
        rescue Errno::ENOENT
          Chef::Log.warn("Cannot delete #{tmp}")
        end
        command = 'ktutil'

        input = []
        enclist.each do |enc|
          input << "addent -password -p #{principal} -k #{kvno} -e #{enc}"
          input << password
        end
        input << "write_kt #{tmp}"
        ktutil_command = Mixlib::ShellOut.new(command, input: input.join("\n"))
        ktutil_command.run_command

        if ktutil_command.error?
          return "rebuilding keytab #{tmp} with #{command} failed #{ktutil_command.stderr}"
        end
        unless KeyTab.keytab_is_ok tmp, kvno, principal, enclist
          return "new keytab #{tmp} had bad contents after #{command}"
        end
        File.rename tmp, keytab
        nil
      end
    end
  end
end
