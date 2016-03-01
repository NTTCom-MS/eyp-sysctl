class sysctl::params {

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[5-6].*$/:
        {
          $sysctlreload='sysctl -p'
        }
        /^7.*$/:
        {
          $sysctlreload='sysctl --system'
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      case $::operatingsystem
      {
      'Ubuntu':
      {
        case $::operatingsystemrelease
        {
          /^14.*$/:
          {
            $sysctlreload='sysctl --system'
          }
          default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
        }
      }
      'Debian': { fail('Unsupported')  }
      default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
