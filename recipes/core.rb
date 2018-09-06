#
# Cookbook Name:: mapr
# Recipe:: core
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Install mapr-core
node['mapr']['core']['packages'].each do |p|
  package p
end
