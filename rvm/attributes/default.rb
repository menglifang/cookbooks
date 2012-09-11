default['rvm']['required_packages'] = %w{ build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion }

set['rvm']['dir']     = "/home/#{node.current_user}/.rvm"
set['rvm']['user']    = "#{node.current_user}"
