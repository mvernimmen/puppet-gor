# == Class: gor::config
#
# Private class. Should not be called directly.
#
class gor::config {
  $ensure = $::gor::ensure
  $args   = $::gor::args

  file { '/var/log/gor':
    ensure => directory,
    mode   => '0755',
  }

  file { '/etc/init/gor.conf':
    ensure  => $ensure,
    content => template('gor/etc/init/gor.conf.erb'),
    require => File['/var/log/gor']
  }
}
