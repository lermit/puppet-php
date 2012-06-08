# = Define: php::module
#
# This define installs and configures php modules
# On Debian and derivatives it install module named php5-${name}
# On RedHat and derivatives it install module named php-${name}
# If you need a custom prefix you can overload default $module_prefix parameter
#
# == Parameters
#
# [*version*]
#   Version to install.
#
# [*absent*]
#   true to ensure package isn't installed.
#
# [*notify_service*]
#   If you want to restart a service automatically when
#   the module is applied. Default: true
#
# [*service_autorestart*]
#   wathever we want a module installation notify a service to restart.
#
# [*service*]
#   Service to restart.
#
# [*module_prefix*]
#   If package name prefix isn't standard.
#
# == Examples
# php::module { 'gd': }
#
# php::module { 'gd':
#   ensure => absent,
# }
#
# This will install php-apc on debian instead of php5-apc
#
# php::module { 'apc':
#   module_prefix => "php-",
# }
#
#
define php::module (
  $version             = $php::params::version,
  $service_autorestart = $php::params::service_autorestart,
  $service             = $php::params::service,
  $module_prefix       = $php::params::module_prefix,
  $absent              = $php::params::absent
  ) {

  include php

  if $absent {
    $real_version = "absent"
  } else {
    $real_version = $version
  }

  $manage_service_autorestart = $service_autorestart ? {
    true    => "Service[$service]",
    false   => undef,
  }

  $real_install_package = "${module_prefix}${name}"

  package { "PhpModule_${name}":
    ensure  => $version,
    name    => $real_install_package,
    notify  => $manage_service_autorestart,
    require => Package['php'],
  }

}
