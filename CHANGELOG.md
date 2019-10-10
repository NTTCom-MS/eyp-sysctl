# CHANGELOG

## 0.3.7

* added support for **RHEL 8**

## 0.3.6

* added **IPv6** settings:
 - ipv6_all_accept_redirects
 - ipv6_default_accept_redirects
 - ipv6_conf_all_accept_ra
 - ipv6_conf_default_accept_ra

## 0.3.5

* added support for **SLES 11.4**

## 0.3.4

* added **manage_config_file** flag

## 0.3.3

* added support for **SLES 11.3**

## 0.3.2

* added support for **SLES 12.3**

## 0.3.1

* added support for **Ubuntu 18.04**
* execshield is no longer an option in sysctl for kernel tuning, starting RHEL7
* disable bridge netfilter options when br_bridge is not loaded

## 0.3.0

* changed bool2num to use eyp-lib's **bool2number**
* **INCOMPATIBLE CHANGE**: changed **ipv4_all_rp_filter** and **ipv4_default_rp_filter** from bool to int

## 0.2.19

* changed default randomize_va_space to 2 for CentOS 6

## 0.2.18

* bugfix **sysctl::randomize_va_space** can be set to 0, 1 and 2

## 0.2.16

* dirty hack to be able to disable a given sysctl setting already configured

## 0.2.15

* changed **concat** and **exec** name to use **$name**

## 0.2.14

*  minor bugfix **sysctl::set**

## 0.2.12

*  added order to **sysctl::set**: minimum value: 59, maximum value: 99

## 0.2.11

* ignore errors on sysctl.conf, for example:

```
[root@localhost ~]# sysctl -p >/dev/null
sysctl: cannot stat /proc/sys/kernel/exec-shield: No such file or directory
```
