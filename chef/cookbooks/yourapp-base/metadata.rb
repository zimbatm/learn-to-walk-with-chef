maintainer       "zimbatm"
maintainer_email "jonas@pandastream.com"
license          "Apache 2.0"
description      "Foo!"
version          "0.0.1"

%w{ ubuntu debian }.each do |os|
  supports os
end
