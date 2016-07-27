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

  $envvars     = $::gor::envvars
  $binary_path = $::gor::binary_path

  $log_ensure = $ensure ? {
    present => directory,
    default => absent,
  }

  file { '/var/log/gor':
    ensure => $log_ensure,
    mode   => '0755',
  }

  if $::osfamily == 'RedHat' and $::operatingsystem != 'Fedora' {
    if $::operatingsystemmajrelease == '6'  {
      file { 'gor-conf':
        ensure  => $ensure,
        path    => '/etc/init/gor.conf',
        mode    => '0644',
        content => template('gor/gor.upstart.erb'),
        require => File['/var/log/gor'],
      }
    } elsif $::operatingsystemmajrelease == '7'  {
      file { 'gor-conf':
        ensure  => $ensure,
        path    => '/lib/systemd/system/gor.service',
        mode    => '0644',
        content => template('gor/gor.systemd.erb'),
        require => File['/var/log/gor'],
      }
    }
  }


}
