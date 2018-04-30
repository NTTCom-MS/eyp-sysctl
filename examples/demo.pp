class { 'sysctl':
}

sysctl::set { 'vm.swappiness':
  value => '69',
  permanent => true,
}
