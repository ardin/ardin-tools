Name:       	ardin-base-system
Version:    	1
Release:    	1%{?dist}
Summary:	Ardin Base System
Group:		ardin

URL:        	https://github.com/ardin/ardin-tools

VCS:        	{{{ git_dir_vcs }}}
Source:     	{{{ git_dir_pack }}}

License:	GPL

%if 0%{?fedora} >= 29
Requires:	iotop sdparm pciutils strace ltrace ethstatus ethtool smartmontools hdparm vim vim-enhanced hddtemp wget sysstat telnet rpmconf mtr bind-utils ntpdate rsync nfs-utils socat iptraf iputils lsof openssh-clients bzip2 links net-tools tcpdump mc whois perl-libwww-perl perl-LWP-Protocol-https git pwgen screen
%else
Requires:	epel-release iotop sdparm pciutils strace ltrace ethstatus ethtool smartmontools hdparm vim vim-enhanced hddtemp wget sysstat telnet rpmconf mtr bind-utils ntpdate rsync nfs-utils socat iptraf iputils lsof openssh-clients bzip2 links net-tools tcpdump mc whois perl-libwww-perl perl-LWP-Protocol-https git pwgen screen
%endif


%description
Ardin Base System for GNU/Linux environments.

%global debug_package %{nil}

%prep
{{{ git_dir_setup_macro }}}

%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/etc/profile.d
install -m 0644 src/etc/profile.d/ardin-base-system.sh ${RPM_BUILD_ROOT}/etc/profile.d/ardin-base-system.sh

%clean
rm -rf ${RPM_BUILD_ROOT}

%post
echo "Install complete." 

%files
%dir /etc/profile.d
/etc/profile.d/ardin-base-system.sh



%changelog
{{{ git_dir_changelog }}}


