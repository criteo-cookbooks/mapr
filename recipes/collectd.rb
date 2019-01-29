#
# Cookbook Name:: mapr
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'mapr'

package 'mapr-collectd' do
  action :upgrade
end
