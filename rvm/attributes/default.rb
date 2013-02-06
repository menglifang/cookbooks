default['rvm']['user']      = node.current_user
default['rvm']['global']    = node.current_user == 'root'
default['rvm']['dir']       = default['rvm']['global'] ? "/usr/local/rvm" : "/home/#{node.current_user}/.rvm"
