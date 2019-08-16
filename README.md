# ardin-tools

Useful bash aliases, functions and other scripts

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

* dnf copr enable ardin/ardin-tools 
* dnf install ardin-tools

**CentOS 7**

* yum install yum-plugin-copr 
* yum copr enable ardin/ardin-tools 
* yum copr install ardin-tools

