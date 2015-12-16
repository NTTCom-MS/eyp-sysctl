# == Class: sysctl
#
# Full description of class sysctl here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'sysctl':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
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
		content => template('sysctl/sysctlbase.erb'),
		notify  => Exec['apply sysctl'],
		audit   => 'content',
	}

	exec {'apply sysctl':
		command     => $sysctl::params::sysctlreload,
		require     => File['sysctl-base'],
		refreshonly => true,
	}

}
