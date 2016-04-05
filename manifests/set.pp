define sysctl::set($value, $setting=$name) {

  concat::fragment{ "sysctl ${setting}":
    target  => '/etc/sysctl.conf',
    content => "${setting}=${value}\n",
    order   => '99',
  }

}
