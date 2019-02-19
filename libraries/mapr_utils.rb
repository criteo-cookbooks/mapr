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

    def unpartitioned_disks(node)
      disks_and_partitions = ::Dir.glob ['/dev/disk/by-id/wwn-*']
      partition_regex = Regexp.new(/-part[0-9]*/)
      partitionned_disks = disks_and_partitions.grep(partition_regex).map{|dev| dev.sub(partition_regex, '')}.uniq
      disks = disks_and_partitions.grep_v(partition_regex)
      unpartitioned = disks - partitionned_disks
      unpartitioned.select do |wwn|
        status = node['block_device'][::File.basename(::File.readlink(wwn))]
        status && status['state'] == 'running' && status['removable'] == '0'
      end.sort
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
    attr_reader :hash

    def initialize(hash)
      @hash = hash
    end

    # rubocop : disable CyclomaticComplexity
    def merge(predicate, hash1, force = false)
      raise "the predicate should be of type: boolean, not: #{predicate.class.name}" unless [true, false].include?(predicate)
      return if hash1.nil?
      @hash = @hash.merge(hash1) if predicate && !force
      @hash = @hash.merge!(hash1) if predicate && force
    end
    # rubocop : enable CyclomaticComplexity
  end

  class NodeType
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
        elements.map { |service| components.include?(service) }.all?
      end

      def components
        Chef.node['mapr']['cluster']['components']
      end
    end
  end
end
