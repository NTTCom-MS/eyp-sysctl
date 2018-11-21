class sysctl::service (
                        $manage_service        = true,
                        $manage_docker_service = false,
                      ) inherits sysctl::params {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if($manage_service)
  {
    #https://docs.puppet.com/puppet/latest/reference/function.html#defined
    if(defined('$::eyp_docker_iscontainer'))
    {
      if(getvar('::eyp_docker_iscontainer')==false or
          $manage_docker_service)
      {
        exec {'apply sysctl':
          command     => $sysctl::params::sysctlreload,
          refreshonly => true,
        }
      }
    }
    else
    {
      exec {'apply sysctl':
        command     => $sysctl::params::sysctlreload,
        refreshonly => true,
      }
    }
  }

}
