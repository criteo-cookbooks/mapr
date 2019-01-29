resource_name :warden_service

property :service, String, name_property: true
property :config, Hash, required: true
property :config_dir, required: true
property :owner, String, default: 'mapr'
property :group, String, default: 'mapr'
property :mode, String, default: '0755'

action :create do
  # Create the directory if it doesn't exit
  config_dir = ::File.join(new_resource.config_dir, 'conf.d')
  directory config_dir do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end

  template ::File.join(config_dir, "warden.#{new_resource.service}.conf") do
    source 'conf.erb'
    variables(config: new_resource.config)
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end
end
