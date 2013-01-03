# Class: php::augeas
#
# Manage php.ini with augeas
#
# Usage:
#
#  php::augeas { 
#    'php-memorylimit':
#      target => '/usr/local/zend/etc/php.ini',
#      entry  => 'PHP/memory_limit',
#      value  => '128M',
#    'php-error_log':
#      target => '/usr/local/zend/etc/php.ini',
#      entry  => 'PHP/error_log',
#      ensure => absent,
#  }

define php::augeas (
  $target = $php::config_file,
  $entry,
  $value = "",
  $ensure = present,
  ) {
  
  include php
   
  $service = $php::service

  $changes = $ensure ? {
    present => [ "set '${entry}' $value" ],
    absent  => [ "rm '${entry}'" ],
  }

  augeas { "php_ini-${name}":
    incl    => $target,
    lens    => 'Php.lns',
    changes => $changes,
  }

}
