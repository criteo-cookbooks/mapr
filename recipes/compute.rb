#
# Cookbook Name:: mapr
# Recipe:: compute
#
# Copyright:: 2018, The Authors, All Rights Reserved.

node['mapr']['compute']['packages'].each do |p|
  package p
end
