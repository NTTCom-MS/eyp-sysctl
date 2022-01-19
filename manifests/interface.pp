define sysctl::interface($rp_filter, $arp_ignore, $arp_announce, $ifname=$name) {

  include ::sysctl

  concat::fragment { "${ifname} ${rp_filter} ${arp_ignore} ${arp_announce}":
    target  => '/etc/sysctl.conf',
    order   => '60',
    content => template("${module_name}/interface.erb")
  }

}
