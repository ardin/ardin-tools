Name:		ardin-tools
Version:	1
Release:	0.1
Summary:	Ardin Tools
Group:		ardin
Source0: 	ardin-tools.tar.gz
License:	GPL
BuildArch:	noarch
BuildRoot:	%{_tmppath}/%{name}-buildroot

%description
Ardin tools for GNU/Linux environments.

%prep
%setup -q

%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/etc/profile.d
install -m 0644 etc/profile.d/ardin-tools.sh ${RPM_BUILD_ROOT}/etc/profile.d/ardin-tools.sh

%clean
rm -rf ${RPM_BUILD_ROOT}
%post
echo "Install complete." 
%files
%dir /etc/profile.d
/etc/profile.d/ardin-tools.sh

