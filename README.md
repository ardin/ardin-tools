# ardin-tools

Useful bash aliases, functions and other scripts

[![Copr build status](https://copr.fedorainfracloud.org/coprs/ardin/ardin-tools/package/ardin-tools/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ardin/ardin-tools/package/ardin-tools/)

## Available functions

* ssl-san - check subject alternative name
* ssl-dates - check expiry certificate dates
* grep-ip - fetch all ip from file
* server-info - get basic information (cpu,hdd,ram) from ssh server
* docker-enter - enter to docker container (script not mine)
* change-root-password - changing root password for given server
* shadow-pass - generate shadow password (eq. for pillar needs)
* server-deinstallation - prepare server for deinstallation
* decrypt-p12 - exctracts file.p12 into key, crt, chain and pem

## Available aliases

* s - ssh
* h - host
* docker-clean - cleans not removed images from disk

## Available scripts
* hosts - network domain checker
* netreport - report traffic from given network

## Installation

**Fedora 30**

* dnf copr enable ardin/ardin-tools -y
* dnf install ardin-tools -y

**CentOS 7**

* yum install yum-plugin-copr -y
* yum copr enable ardin/ardin-tools -y
* yum install ardin-tools -y

