source 'https://rubygems.org'

gem 'berkshelf'
gem 'chefspec'
gem 'kitchen-inspec'
gem 'rake'
gem 'foodcritic'
gem 'chef-zero-scheduled-task'
gem 'chef'

gem 'kitchen-transport-speedy'
group :ec2 do
  gem 'test-kitchen'
  gem 'kitchen-ec2', git: 'https://github.com/criteo-forks/kitchen-ec2.git', branch: 'criteo'
  gem 'winrm',       '>= 1.6'
  gem 'winrm-fs',    '>= 0.3'
  gem 'dotenv'
end

# Other gems should go after this comment
gem 'rubocop', '=0.58.2'
gem 'chef-vault'
gem 'inspec', '2.1.0'
