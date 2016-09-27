# == Class: gor::package
#
# Private class. Should not be called directly.
#
class gor::package {
  $binary_path   = $::gor::binary_path
  $ensure        = $::gor::ensure
  $version       = $::gor::version
  $digest_string = $::gor::digest_string
  $digest_type   = $::gor::digest_type
  $runuser       = $::gor::runuser
  $source_url    = $::gor::source_url

  $source_url_real = $source_url ? {
    undef => "https://github.com/buger/gor/releases/download/v${version}/gor_v${version}_x64.tar.gz",
    default => $source_url,
  }

  archive { "gor-${version}" :
    ensure           => $ensure,
    url              => $source_url_real,
    target           => $binary_path,
    follow_redirects => true,
    extension        => 'tar.gz',
    digest_string    => $digest_string,
    digest_type      => $digest_type,
    src_target       => '/tmp',
    root_dir         => '.',
  }

  # If gor is not running as root, set up permissions to capture traffic
  if ($runuser != 'root') {
    exec { "setcap \"cap_net_raw,cap_net_admin+eip\" ${binary_path}/gor":
      path        => ['/sbin', '/usr/sbin'],
      subscribe   => Archive["gor-${version}"],
      refreshonly => true,
    }
  }


}

