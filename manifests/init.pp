# == Class: sysctl
#
# concat order:
# 00: base
# 98: custom settings banner
# 99: custom settings
#
class sysctl(
              $manage_service        = true,
              $manage_docker_service = false,
              $disable_ipv6          = true,
            ) inherits sysctl::params {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  concat { '/etc/sysctl.conf':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Class['sysctl::service'],
  }

  concat::fragment{ 'base sysctl':
    target  => '/etc/sysctl.conf',
    content => template("${module_name}/sysctlbase.erb"),
    order   => '00',
  }

  class { 'sysctl::service':
    manage_service        => $manage_service,
    manage_docker_service => $manage_docker_service,
  }

}
