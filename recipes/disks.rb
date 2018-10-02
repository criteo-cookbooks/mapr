#
# Cookbook Name:: mapr
# Recipe:: disks
#
# Copyright:: 2018, The Authors, All Rights Reserved.

mapr_disksetup 'format all disks' do
  disks node['mapr']['mfs']['disks'].sort
  stripe_width node['mapr']['mfs']['stripe_width']
  opts %w[-W -F]
end
