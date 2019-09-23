package 'mapr-httpfs' do
  action :upgrade
end

include_recipe 'mapr::config'
warden_service 'httpfs' do
  config node['mapr']['warden']['httpfs']['config']
  config_dir node['mapr']['config']['config_dir']
end
