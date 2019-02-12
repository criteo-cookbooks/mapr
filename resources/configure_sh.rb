# Resource properties
property :basic_opts, Hash
property :additional_opts, Hash

load_current_value do |new_resource|
  basic_opts ::Mapr::ConfigureSh.load_options(new_resource.name, 'basic')
  additional_opts ::Mapr::ConfigureSh.load_options(new_resource.name, 'add')
end

# The run action build a command line with the options (basic and additional) and execute it
action :run do
  converge_if_changed(:basic_opts, :additional_opts) do
    name = new_resource.name
    basic_opts = new_resource.basic_opts
    additional_opts = new_resource.additional_opts
    execute "MapR #{name}" do
      command ::Mapr::ConfigureSh.build_command((basic_opts || {}).merge(additional_opts || {}))
    end
    # We store the options in a specific file to be able to compare for idempotency
    ::Mapr::ConfigureSh.store_options(name, basic_opts, additional_opts)
  end
end

# For reload action, we simply add the '-R' to the future command line
# We don't use converge_if_changed here because we consider it should be run every time it's called
# So, We highly recommend to use this action with a notify.
action :reload do
  name = new_resource.name
  basic_opts = new_resource.basic_opts
  additional_opts = new_resource.additional_opts
  execute "MapR #{name}" do
    command ::Mapr::ConfigureSh.build_command((basic_opts || {}).merge(additional_opts || {}).merge('-R' => true))
  end
end
