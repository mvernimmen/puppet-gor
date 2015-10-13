# == Class: gor::service
#
# Private class. Should not be called directly.
#
class gor::service {
  $args           = $::gor::args
  
  if empty($args) {
    $override_ensure = absent
    $service_enable = false
  } else {
    $ensure = present
    $service_ensure = $::gor::service_ensure
    $service_enable = $service_ensure ? {
      stopped => false,
      false   => false,
      default => true,
    }
  }

  if !$service_enable {
    file { '/etc/init/gor.override':
      ensure  => $override_ensure,
      content => "start on manual\nstop on manual"
    }
  } else {
    # don't try to stop the service if it was started through capistrano
    # or manually
    # Disable `hasrestart` because upstart's `initctl restart` doesn't reload
    # the config to pick up the new `exec` command when our arguments change.
    service { 'gor':
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => true,
      hasrestart => false,
      provider   => 'upstart',
    }
  }
}
