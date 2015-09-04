# == Class: gor
#
# Run an instance of Gor for traffic replay.
#
# === Parameters
#
# [*ensure*]
#   Ensure parameter to pass to the package.
#   Default: present
#
# [*version*]
#   version of the package.
#   Default: 0.10.0
#
# [*service_ensure*]
#   Ensure parameter to pass to the service.
#   Default: running
#
# [*args*]
#   Hash of arguments to run Gor with. Values will be single quoted.
#
#
class gor (
  $ensure         = present,
  $version        = '0.10.0',
  $service_ensure = stopped,
  $args           = undef
) {
  validate_hash($args)
  if empty($args) {
    fail("${title}: args param is empty")
  }

  anchor { 'gor::begin': } ->
  class { 'gor::package': } ->
  class { 'gor::config': } ~>
  class { 'gor::service': } ->
  anchor { 'gor::end': }

  Anchor['gor::begin']  ~> Class['gor::service']
  Class['gor::package'] ~> Class['gor::service']
}
