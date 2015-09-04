# == Class: gor::service
#
# Private class. Should not be called directly.
#
class gor::service {
  $service_ensure = $::gor::service_ensure
  $service_enable = $service_ensure ? {
    stopped => true,
    false   => true,
    absent  => false,
    default => true,
  }

  # Disable `hasrestart` because upstart's `initctl restart` doesn't reload
  # the config to pick up the new `exec` command when our arguments change.
  # service { 'gor':
  #   ensure     => $service_ensure,
  #   enable     => $service_enable,
  #   hasstatus  => true,
  #   hasrestart => false,
  #   provider   => 'upstart',
  # }
}
