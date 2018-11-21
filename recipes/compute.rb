#
# Cookbook Name:: mapr
# Recipe:: compute
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'mapr'

package node['mapr']['compute']['packages'] do
  action :upgrade
end

include_recipe 'mapr::disks'
include_recipe 'mapr::config'
