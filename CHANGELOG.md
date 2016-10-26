# CHANGELOG

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
