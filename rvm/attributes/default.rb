default['rvm']['global']    = false
default['rvm']['user']      = node.current_user
default['rvm']['dir']       = "/home/#{node.current_user}/.rvm"
