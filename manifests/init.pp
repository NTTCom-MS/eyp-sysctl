# == Class: sysctl
#
class sysctl(
            ) inherits sysctl::params {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  file { 'sysctl-base':
    ensure  => file,
    path    => '/etc/sysctl.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/sysctlbase.erb"),
    notify  => Class['sysctl::service'],
    audit   => 'content',
  }

  class { 'sysctl::service':
  }

}
