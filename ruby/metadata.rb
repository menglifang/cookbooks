maintainer       "Beijing Menglifang Network Science and Technology Co.Ltd."
maintainer_email "towerhe@gmail.com"
license          "Apache License, Version 2.0"
description      "Installs/Configures ruby"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "ruby", "Install Ruby"

depends "rvm"

%w{ debian ubuntu }.each do |os|
  supports os
end
