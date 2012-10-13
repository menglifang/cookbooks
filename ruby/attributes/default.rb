default['ruby']['mri']['required_packages'] = %w{ build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config }

default['ruby']['interpreter'] = 'mri'
default['ruby']['version'] = '1.9.3'

default['current_user'] = node.current_user
