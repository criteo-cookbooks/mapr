# Resource properties
property :basic_opts, Hash
property :additional_opts, Hash

action :run do
  name = new_resource.name
  basic_opts = new_resource.basic_opts
  additional_opts = new_resource.additional_opts

  configuration = (basic_opts || {}).merge(additional_opts || {})

  return if configuration.empty?
  cmd = ::Mapr::ConfigureSh.build_command(configuration)

  execute "MapR #{name}" do
    command cmd
  end
end
