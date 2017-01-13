# ardin-tools

Usefull public bash aliases and functions

## Available functions

* ssl-sni
* ssl-dates

## Available aliases

* s - ssh
* docker-clean - cleans not removed images from disk


## Installation

### From repo (fast)

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

