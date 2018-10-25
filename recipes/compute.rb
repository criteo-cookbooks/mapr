#
# Cookbook Name:: mapr
# Recipe:: compute
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package node['mapr']['compute']['packages'] do
  action :upgrade
end
