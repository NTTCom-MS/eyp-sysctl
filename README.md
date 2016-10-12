# sysctl

![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What sysctl affects](#what-sysctl-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with sysctl](#beginning-with-sysctl)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)

## Overview

manages sysctl settings

## Module Description

manages sysctl permanent and temporal settings, does **NOT** use **sysctl.d**.

## Setup

### What sysctl affects

* /etc/sysctl.conf

### Setup Requirements

This module requires pluginsync enabled

### Beginning with sysctl

```puppet
sysctl::set { 'vm.dirty_expire_centisecs':
  value => '500',
}
```

## Usage

Temporal settings (will not be present on /etc/sysctl.conf):

```puppet
class { 'sysctl': }

sysctl::set { 'vm.swappiness':
  value => '69',
  permanent => false,
}
```

multi value usage:

```puppet
#kernel.sem=250 32000 100 128

sysctl::set { 'kernel.sem':
  value => "250\t32000\t100\t128",
}
```


## Reference

### classes

#### sysctl

* **manage_service**: determines whether Puppet manages sysctl reloads (default: true)
* **manage_docker_service**: sysctl reload will fail in a docker container, setting this to false will not refresh changes (default: false)
* **disable_ipv6**: add the following sysctl settings to disable IPv6:
  * **net.ipv6.conf.all.disable_ipv6** = 1
  * **net.ipv6.conf.all.accept_redirects** = 0
  * **net.ipv6.conf.default.accept_redirects** = 0
* **disable_netfilter_on_bridges**: (default: true)
  * **net.bridge.bridge-nf-call-ip6tables** = 0
  * **net.bridge.bridge-nf-call-iptables** = 0
  * **net.bridge.bridge-nf-call-arptables** = 0
* **sysrq**: (default: false)
* **core_uses_pid**: (default: true)
* **ipv4_tcp_syncookies**: (default: true)
* **netfilter_on_bridges**: (default: false)
* **execshield**: (default: true)
* **randomize_va_space**: (default: true)
* **suid_dumpable**: (default: false)
* **shmall**: (default: 4294967296)
* **shmmax**: (default: 68719476736)
* **msgmax**: (default: 65536)
* **msgmnb**: (default: 65536)
* **ipv4_ip_forward**: (default: false)
* **ipv4_icmp_echo_ignore_broadcasts**: (default: true)
* **ipv4_icmp_ignore_bogus_error_responses**: (default: true)
* **ipv4_all_log_martians**: (default: true)
* **ipv4_default_log_martians**: (default: true)
* **ipv4_all_accept_source_route**: (default: false)
* **ipv4_default_accept_source_route**: (default: false)
* **ipv4_all_rp_filter**: (default: true)
* **ipv4_default_rp_filter**: (default: true)
* **ipv4_all_accept_redirects**: (default: false)
* **ipv4_default_accept_redirects**: (default: false)
* **ipv4_all_secure_redirects**: (default: false)
* **ipv4_default_secure_redirects**: (default: false)
* **ipv4_all_send_redirects**: (default: false)
* **ipv4_default_send_redirects**: (default: false)

### defines

#### sysctl::set

* **setting**: (default: name)
* **value**:
* **permanent**: if true, is added to /etc/sysctl.conf, otherwise it's set using sysctl -w (default: true)
* **order**: minimum value: 59, maximum value: 99 (default: 59)

## Limitations

Tested on:
* CentOS 5
* CentOS 6
* CentOS 7
* Ubuntu 14.04

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

* ignore errors:  *-e Use this option to ignore errors about unknown keys.*

* Support for:
  * CentOS 5
  * CentOS 7
  * Ubuntu 14.04


### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
