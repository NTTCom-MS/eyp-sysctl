class sysctl::params {

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[5-6].*$/:
        {
          $sysctlreload='sysctl -e -p'
        }
        /^7.*$/:
        {
          $sysctlreload='sysctl -e --system'
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
          /^1[46].*$/:
          {
            $sysctlreload='sysctl -e --system'
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
