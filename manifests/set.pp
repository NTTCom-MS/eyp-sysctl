define sysctl::set($value, $setting=$name) {

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

  #per actualitzar en calent via exec
  # root@preedit1:~# sysctl vm.swappiness
  # vm.swappiness = 0


}
