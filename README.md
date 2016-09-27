
# puppet-gor
[![Puppet Forge Version](http://img.shields.io/puppetforge/v/meltwater/gor.svg)](https://forge.puppetlabs.com/meltwater/gor)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/meltwater/gor.svg)](https://forge.puppetlabs.com/meltwater/gor)
[![CircleCI branch](https://img.shields.io/circleci/project/meltwater/puppet-gor/master.svg)](https://circleci.com/gh/meltwater/puppet-gor)
[![By Meltwater](https://img.shields.io/badge/by-meltwater-28bbbb.svg)](http://underthehood.meltwater.com/)
[![Maintenance](https://img.shields.io/maintenance/yes/2016.svg)](https://github.com/meltwater/puppet-gor/commits/master)
[![license](https://img.shields.io/github/license/meltwater/puppet-gor.svg)](https://github.com/meltwater/puppet-gor/blob/master/LICENSE)

Puppet module for [Gor](https://github.com/buger/gor/).

Installs Gor, configures an upstart job with the appropriate arguments, and
starts the service.

## Example usage

Pass some arguments:
```puppet
class { '::gor':
  args => {
    '-input-raw'             => 'localhost:7999',
    '-output-http-header'    => 'User-Agent: gor',
    '-output-http'           => 'https://staging.example.com',
    '-output-http-redirects' => 2,
    '-output-http-timeout'   => '120s'
  },
}
```

The same argument can be specified multiple times by passing an array:
```puppet
class { '::gor':
  args => {
    …
    '-output-http-method' => [
      'GET', 'HEAD', 'OPTIONS'
    ],
  },
}
```

To install a specific version of the Gor package:
check https://github.com/buger/gor/releases
```puppet
class { '::gor':
  version       => '0.14.1',
  digest_string => '0c0335a323c416569f030f46a7541045',
  digest_type   => 'md5',
  …
}
```

To install a specific version of the Gor package from a custom source url:
check https://github.com/buger/gor/releases
```puppet
class { '::gor':
  version       => '0.15.1',
  source_url    => 'https://github.com/buger/gor/releases/download/v0.15.1/gor_v0.15.1_x64.tar.gz'
  digest_string => 'ced467f51da7491a227b871c9894d351',
  digest_type   => 'md5',
  …
}
```

To install gor to a different bin location:
```puppet
class { '::gor':
  binary_path => '/usr/bin', # default: '/usr/local/bin'
  …
}
```

To set custom environment variables in the start scripts:
```puppet
class { '::gor':
  envvars => {
    'GODEBUG' => 'netdns=go',
    'FOO'     => 'bar',
  }
  …
}
```

To run gor under a normal user account and limit gor's memory usage:
```puppet
class { '::gor':
  memory_limit => '100M',
  runuser      => 'gor',
  …
}
```

To prevent the service from starting:
```puppet
class { '::gor':
  manage_service => false,
  …
}
```

To install the Gor package with a gor service but that can only be started manually:
```puppet
class { '::gor':
  version       => '0.14.1',
  digest_string => 'ced467f51da7491a227b871c9894d351',
  digest_type   => 'md5',
  manage_service => false,
  args => {
    '-input-raw'             => 'localhost:7999',
    '-output-http-header'    => 'User-Agent: gor',
    '-output-http'           => 'https://staging.example.com',
    '-output-http-redirects' => 2,
    '-output-http-timeout'   => '120s'
  },
}
```

To install the Gor package with a gor service running that always send requests to https://staging.example.com
```puppet
class { '::gor':
  version       => '0.14.1',
  digest_string => 'ced467f51da7491a227b871c9894d351',
  digest_type   => 'md5',
  args => {
    '-input-raw'             => 'localhost:7999',
    '-output-http-header'    => 'User-Agent: gor',
    '-output-http'           => 'https://staging.example.com',
    '-output-http-redirects' => 2,
    '-output-http-timeout'   => '120s'
  },
}
```

## License

See [LICENSE](LICENSE) file.
