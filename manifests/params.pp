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
          $randomize_va_space_default='2'
        }
        /^7.*$/:
        {
          $sysctlreload='sysctl -e --system'
          $randomize_va_space_default='1'
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
          /^1[468].*$/:
          {
            $sysctlreload='sysctl -e --system'
            $randomize_va_space_default='1'
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
