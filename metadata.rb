name             'ipset'
maintainer       'Brad Ison'
maintainer_email 'bison@garbagebrain.org'
license          'Apache 2.0'
source_url       'https://github.com/bison/ipset-cookbook'
description      'Installs/Configures ipset on Linux'
version          '0.2.1'

%w(debian ubuntu).each do |os|
  supports os
end
