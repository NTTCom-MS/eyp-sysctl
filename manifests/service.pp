class sysctl::service($manage_docker_service=false,) inherits sysctl::params {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if(getvar('::eyp_docker_iscontainer')==undef or
      getvar('::eyp_docker_iscontainer')==false or
      getvar('::eyp_docker_iscontainer') =~ /false/ or
      $manage_docker_service)
  {
    exec {'apply sysctl':
      command     => $sysctl::params::sysctlreload,
      require     => Concat['/etc/sysctl.conf'],
      refreshonly => true,
    }
  }
}
