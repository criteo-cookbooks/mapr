#
# Cookbook Name:: mapr
# Recipe:: repositories
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Create MapR tech repository
yum_repository 'maprtech' do
  description 'MapR Technologies'
  baseurl node['mapr']['repositories']['release_url']
  gpgkey node['mapr']['repositories']['gpg_url']
  action :create
end

# Create MapR ecosystem repository
yum_repository 'maprecosystem' do
  description 'MapR Ecosystem'
  baseurl node['mapr']['repositories']['ecosystem_url']
  gpgkey node['mapr']['repositories']['gpg_url']
  action :create
end
