maintainer       "Beijing Menglifang Network Science and Technology CO.,LTD."
maintainer_email "towerhe@gmail.com"
license          "Apache License Version 2.0"
description      "Installs/Configures passenger-nginx"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "passenger-nginx", "Install passenger-nginx"

depends "ruby"

%w{ debian ubuntu }.each do |os|
  supports os
end
