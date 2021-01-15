class sysctl::params {

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[5-6].*$/:
        {
          $execshield_default=true
          $sysctlreload='sysctl -e -p'
          $randomize_va_space_default='2'
        }
        /^[7-8].*$/:
        {
          $execshield_default=undef
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
          /^(1[468]|20).*$/:
          {
            $execshield_default=undef
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
    'Suse':
    {
      case $::operatingsystem
      {
        'SLES':
        {
          case $::operatingsystemrelease
          {
            '11.3':
            {
              $execshield_default=undef
              $sysctlreload='sysctl -e -p'
              $randomize_va_space_default='1'
            }
            /^12.[34]/:
            {
              $execshield_default=undef
              $sysctlreload='sysctl -e --system'
              $randomize_va_space_default='2'
            }
            default: { fail("Unsupported operating system ${::operatingsystem} ${::operatingsystemrelease}") }
          }
        }
        default: { fail("Unsupported operating system ${::operatingsystem}") }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
