# ardin-tools

Usefull public bash aliases and functions

## Available functions

* ssl-san - check subject alternative name
* ssl-dates - check expiry certificate dates
* grep-ip - fetch all ip from file
* server-info - get basic information (cpu,hdd,ram) from ssh server
* docker-enter - enter to docker container (script not mine)
* change-root-password - changing root password for given server
* shadow-pass - generate shadow password (eq. for pillar needs)
* server-deinstallation - prepare server for deinstallation

## Available aliases

* s - ssh
* h - host
* docker-clean - cleans not removed images from disk

## Todo

### Available scripts
* hosts - network domain checker
* netreport - report traffic from given network

## Installation

### From repo

#### CentOS 6 / 7
Enable repository
<pre>
# curl -o /etc/yum.repos.d/hyperit.repo http://rpm.hyperit.pl/yum/hyperit.repo
</pre>

Install package via yum, eq.
<pre>
# yum install ardin-tools
</pre>

### From source
<pre>
# curl -k -o /etc/profile.d/ardin-tools https://raw.githubusercontent.com/ardin/ardin-tools/master/SOURCES/etc/profile.d/ardin-tools.sh
</pre>

