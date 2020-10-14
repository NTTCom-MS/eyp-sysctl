class { 'sysctl':
}

sysctl::set { 'vm.swappiness':
  value     => '69',
  permanent => true,
}

sysctl::set { 'kernel.sem':
  value => "250\t32000\t100\t128",
}
