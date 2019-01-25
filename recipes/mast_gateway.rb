# Configue the mastgateway
package 'mapr-mastgateway'

include_recipe 'mapr::config'
warden_service 'mastgateway' do
  config node['mapr']['warden']['mastgateway']['config']
  config_dir node['mapr']['config']['config_dir']
end