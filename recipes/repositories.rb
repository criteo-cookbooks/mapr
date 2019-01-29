#
# Cookbook Name:: mapr
# Recipe:: repositories
#
# Copyright:: 2018, The Authors, All Rights Reserved.

yum_repository 'maprcore' do
  description 'MapR Core repository'
  baseurl node['mapr']['repositories']['core_url']
  gpgkey node['mapr']['repositories']['gpg_url']
  action :create
end

# Create MapR ecosystem repository
yum_repository 'maprexpansionpack' do
  description 'MapR Expansion Pack repository'
  baseurl node['mapr']['repositories']['expansionpack_url']
  gpgkey node['mapr']['repositories']['gpg_url']
  action :create
end
