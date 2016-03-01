class sysctl::service inherits sysctl::params {

  if($::eyp_docker_iscontainer==undef or $::eyp_docker_iscontainer =~ /false/)
  {
    exec {'apply sysctl':
      command     => $sysctl::params::sysctlreload,
      require     => File['sysctl-base'],
      refreshonly => true,
    }
  }
}
