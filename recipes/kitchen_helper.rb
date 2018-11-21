###
#
#     Attention : This recipe is only used for tests purposes please
#     Avoid to include it in your run_list

execute 'Set !require tty for kitchen user' do
  action :run
  command 'echo "Defaults!ALL !requiretty" >> /etc/sudoers.d/kitchen'
  not_if 'grep "Defaults!ALL !requiretty" /etc/sudoers.d/kitchen'
end
