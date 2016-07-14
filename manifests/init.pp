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
# [*envvars*]
#   Environment variables to be passed into the upstart config. This could
#   be used to turn on debugging options.
#
# [*binary_path*]
#   Specify the location of the Gor binary.
#
# [*args*]
#   Hash of arguments to run Gor with. Values will be single quoted.
#
class gor (
  $ensure         = present,
  $version        = '0.10.1',
  $digest_string  = '6d7a23e5ae97edec6fa389cdee9546be',
  $digest_type    = 'md5',
  $service_ensure = running,
  $envvars = {},
  $binary_path = '/usr/bin/gor',
  $args           = {}
) {
  validate_hash($args)
  if empty($args) {
    fail("${title}: args param is empty")
  }

  validate_hash($envvars)

  anchor { 'gor::begin': } ->
  class { 'gor::package': } ->
  class { 'gor::config': } ~>
  class { 'gor::service': } ->
  anchor { 'gor::end': }

  Anchor['gor::begin']  ~> Class['gor::service']
  Class['gor::package'] ~> Class['gor::service']
}
