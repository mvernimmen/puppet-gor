# == Class: gor::package
#
# Private class. Should not be called directly.
#
class gor::package {
  $ensure  = $::gor::ensure
  $version = $::gor::version

  archive { 'gor':
    ensure           => $ensure,
    url              => "https://github.com/buger/gor/releases/download/${version}/gor_${version}_x64.tar.gz",
    target           => '/usr/local/bin',
    follow_redirects => true,
    extension        => 'tar.gz',
    checksum         => false,
    src_target       => '/tmp'
  }
}
