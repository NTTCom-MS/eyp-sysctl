# == Class: sysctl
#
# concat order:
# 00: base
# 98: custom settings banner
# 99: custom settings
#
class sysctl(
              $manage_docker_service=false,
            ) inherits sysctl::params {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  concat { '/etc/sysctl.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Class['sysctl::service'],
  }

  concat::fragment{ 'base sysctl':
    target  => '/etc/sysctl.conf',
    content => template("${module_name}/sysctlbase.erb"),
    order   => '00',
  }

  class { 'sysctl::service':
    manage_docker_service => $manage_docker_service,
  }

}
