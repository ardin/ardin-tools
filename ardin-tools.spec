Name:       	{{{ git_dir_name }}}
Version:    	{{{ git_dir_version }}}
Release:    	1%{?dist}
Summary:	Ardin Tools
Group:		ardin

URL:        	https://github.com/ardin/ardin-tools

VCS:        	{{{ git_dir_vcs }}}
Source:     	{{{ git_dir_pack }}}

License:	GPL

%description
Ardin tools for GNU/Linux environments.

%global debug_package %{nil}

%prep
{{{ git_dir_setup_macro }}}

%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/etc/profile.d
install -m 0644 src/etc/profile.d/ardin-tools.sh ${RPM_BUILD_ROOT}/etc/profile.d/ardin-tools.sh

install -m 0755 -d $RPM_BUILD_ROOT/usr/bin
install -m 0755 src/usr/bin/hosts ${RPM_BUILD_ROOT}/usr/bin/hosts
install -m 0755 src/usr/bin/netreport ${RPM_BUILD_ROOT}/usr/bin/netreport

%clean
rm -rf ${RPM_BUILD_ROOT}

%post
echo "Install complete." 

%files
%dir /etc/profile.d
/etc/profile.d/ardin-tools.sh
/usr/bin/hosts
/usr/bin/netreport


%changelog
{{{ git_dir_changelog }}}


