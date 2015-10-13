# == Class: gor::package
#
# Private class. Should not be called directly.
#
class gor::package {
  $ensure        = $::gor::ensure
  $version       = $::gor::version
  $digest_string = $::gor::digest_string
  $digest_type   = $::gor::digest_type

  archive { "gor-${version}" :
    ensure           => $ensure,
    url              => "https://github.com/buger/gor/releases/download/v${version}/gor_${version}_x64.tar.gz",
    target           => '/usr/local/bin',
    follow_redirects => true,
    extension        => 'tar.gz',
    digest_string    => $digest_string,
    digest_type      => $digest_type,
    src_target       => '/tmp'
  }
}
