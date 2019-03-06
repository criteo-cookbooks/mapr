require 'kitchen'

desc 'Run kitchen tests'
task :test_kitchen do
  Kitchen.logger = Kitchen.default_file_logger
  @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.ec2.yml')
  config = Kitchen::Config.new(loader: @loader)
  config.instances.each do |instance|
    instance.test(:always)
  end
end

task default: [:test_kitchen] if ENV['encrypted_eb3fc2d5c3da_iv']
