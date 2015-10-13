# == Class: gor::config
#
# Private class. Should not be called directly.
#
class gor::config {
  $args   = $::gor::args
  if empty($args) {
    $ensure = absent
  } else {
    $ensure = $::gor::ensure
  }

  $log_ensure = $ensure ? {
    present => directory,
    default => absent,
  }

  file { '/var/log/gor':
    ensure => $log_ensure,
    mode   => '0755',
  }

  file { '/etc/init/gor.conf':
    ensure  => $ensure,
    content => template('gor/etc/init/gor.conf.erb'),
    require => File['/var/log/gor']
  }
}
