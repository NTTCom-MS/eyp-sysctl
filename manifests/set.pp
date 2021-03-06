define sysctl::set(
                    $value,
                    $setting   = $name,
                    $permanent = true,
                    $order     = '42',
                    $enable    = true,
                  ) {

  Exec{
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if($enable)
  {
    include ::sysctl

    if($permanent)
    {
      if(!defined(Concat::Fragment['sysctl settings banner']))
      {
        concat::fragment{ 'sysctl settings banner':
          target  => '/etc/sysctl.conf',
          content => "\n\n# custom settings\n\n",
          order   => '58',
        }
      }

      concat::fragment{ "sysctl ${setting} ${name}":
        target  => '/etc/sysctl.conf',
        content => "${setting}=${value}\n",
        order   => "59-${order}",
      }
    }

    #per actualitzar en calent via exec
    # [jprats@croscat ~]$ sysctl -n vm.swappiness
    # 1

    # [jprats@croscat ~]$ sudo sysctl -w vm.swappiness=60
    # vm.swappiness = 60

    exec { "update sysctl ${setting} ${value} ${name}":
      command => "sysctl -w '${setting}=${value}'",
      unless  => "sysctl -n ${setting} | grep -P \"${value}\"",
      require => Concat['/etc/sysctl.conf'],
    }
  }
}
