name             'mapr'
maintainer       'Criteo'
maintainer_email 'lake-storage@criteo.com'
license          'Apache-2.0'
description      'MapR cookbook'
long_description 'Install and configure MapR'
issues_url       'https://github.com/criteo-cookbooks/mapr/issues'
source_url       'https://github.com/criteo-cookbooks/mapr'
version          '0.3.0'
supports         'centos'

chef_version '>= 12.5' if respond_to?(:chef_version)

depends 'java' '>= 8.0.0'
depends 'sysctl' # sysctl will be integrated as a chef resource in Chef 14. We still need it so far
depends 'chef-vault'
