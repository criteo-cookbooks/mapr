#
# Cookbook Name:: mapr
# Recipe:: disks
#
# Copyright:: 2018, The Authors, All Rights Reserved.

mapr_disksetup 'format all disks' do
  disks node['mapr']['mfs']['config']['disks'].sort
  stripe_width node['mapr']['mfs']['config']['stripe_width']
  opts %w[-W -F]
  only_if {ENV['TEST_KITCHEN'].nil?}
end
