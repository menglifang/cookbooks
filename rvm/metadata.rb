maintainer       "Tower He"
maintainer_email "towerhe@gmail.com"
license          "MIT"
description      "Installs/Configures rvm"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "rvm", "Install RVM"

depends "git"

%w{ debian ubuntu }.each do |os|
  supports os
end
