Name:		ardin-tools
Version:	9
Release:	15
Summary:	Ardin Tools
Group:		ardin
Source0: 	netreport
Source1: 	hosts
Source2: 	ardin-tools.sh
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
# install -m 0644 ardin-tools.sh ${RPM_BUILD_ROOT}/etc/profile.d/ardin-tools.sh

%clean
rm -rf ${RPM_BUILD_ROOT}
%post
echo "Install complete." 
%files
%dir /etc/profile.d
/etc/profile.d/ardin-tools.sh

