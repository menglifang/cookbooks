current_user = fix_encoding(Etc.getpwuid.name)

set['rvm']['user']    = current_user
set['rvm']['dir']     = current_user == 'root' ? "/usr/local/rvm" : "/home/#{current_user}/.rvm"
