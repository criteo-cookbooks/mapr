#
# Cookbook Name:: mapr
# Recipe:: core
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package node['mapr']['core']['packages'] do
  action :upgrade
end
