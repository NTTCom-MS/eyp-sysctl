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
