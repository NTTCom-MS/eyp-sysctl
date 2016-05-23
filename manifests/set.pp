define sysctl::set(
                    $value,
                    $setting   = $name,
                    $permanent = true,
                  ) {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if($permanent)
  {
    if(!defined(Concat::Fragment['sysctl settings banner']))
    {
      concat::fragment{ 'sysctl settings banner':
        target  => '/etc/sysctl.conf',
        content => "\n\n# custom settings\n\n",
        order   => '98',
      }
    }

    concat::fragment{ "sysctl ${setting}":
      target  => '/etc/sysctl.conf',
      content => "${setting}=${value}\n",
      order   => '99',
    }
  }

  #per actualitzar en calent via exec
  # [jprats@croscat ~]$ sysctl -n vm.swappiness
  # 1

  # [jprats@croscat ~]$ sudo sysctl -w vm.swappiness=60
  # vm.swappiness = 60

  exec { "update sysctl ${setting} ${value}":
    command => "sysctl -w '${setting}=${value}'",
    unless  => "sysctl -n ${setting} | grep ${value}",
    require => Concat['/etc/sysctl.conf'],
  }


}
