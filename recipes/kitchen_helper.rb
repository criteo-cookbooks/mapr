###
#
#     Attention : This recipe is only used for tests purposes please
#     Avoid to include it in your run_list

execute 'Set !require tty for kitchen user' do
  action :run
  command 'echo "Defaults!ALL !requiretty" >> /etc/sudoers.d/kitchen'
  not_if 'grep "Defaults!ALL !requiretty" /etc/sudoers.d/kitchen'
end

if ENV['TEST_KITCHEN'].nil?
  ruby_block 'This recipe should not be included in prod' do
    block do
      raise "This recipe is used to facilitate test due to issue in kitchen-ec. It
will removed one the issue is fixed."
    end
  end
end
