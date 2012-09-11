maintainer       "Tower He"
maintainer_email "towerhe@gmail.com"
license          "MIT"
description      "Installs/Configures nginx"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "nginx", "Install nginx with passenger module"

depends "rvm"

%w{ debian ubuntu }.each do |os|
  supports os
end
