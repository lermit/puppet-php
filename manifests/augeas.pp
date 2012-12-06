# Class: php::augeas
#
# Manage php.ini through augeas
#
# Usage:
# php::augeas {
#
define php::augeas (
  $target = $php::config_file,
  $entry,
  $value = "",
  $ensure = present,
  ) {
   
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
