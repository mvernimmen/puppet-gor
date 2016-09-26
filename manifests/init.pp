# == Class: gor
#
# Run an instance of Gor for traffic replay.
#
# === Parameters
#
# [*args*]
#   Hash of arguments to run Gor with. Values will be single quoted.
#
# [*binary_path*]
#   Specify the location of the Gor binary.
#
# [*ensure*]
#   Ensure parameter to pass to the package.
#   Default: present
#
# [*envvars*]
#   Environment variables to be passed into the upstart config. This could
#   be used to turn on debugging options.
#
# [*memory_limit*]
#   Limit using cgroups the amount of memory that gor is allowed to use at
#   most. Currently only implemented for RHEL and derivatives. Default is
#   unlimited.
#
# [*runuser*]
#   Defines as which user gor executable should be running. Currently only
#   implemented for RHEL and derivatives. You need to make sure the user already
#   exists. If this is set to something other than 'root' (the default) then gor
#   will also be given capabilities through capset to do it's thing.
#
# [*service_ensure*]
#   Ensure parameter to pass to the service.
#   Default: running
#
# [*version*]
#   version of the package.
#   Default: 0.15.1
#
#
class gor (
  $ensure         = present,
  $version        = '0.15.1',
  $digest_string  = 'ced467f51da7491a227b871c9894d351',
  $digest_type    = 'md5',
  $source_url     = undef,
  $manage_service = true,
  $memory_limit   = 'unlimited',
  $runuser        = 'root',
  $service_ensure = running,
  $envvars        = {},
  $binary_path    = '/usr/local/bin',
  $args           = {}
) {

  if $manage_service {
    validate_hash($args)
    if empty($args) {
      fail("${title}: args param is empty")
    }
  }
  validate_hash($envvars)

  class { '::gor::package': } ->
  class { '::gor::config': } ->
  class { '::gor::service': }

  Class['gor::package'] ~> Class['gor::config']
  Class['gor::config'] ~> Class['gor::service']
}

