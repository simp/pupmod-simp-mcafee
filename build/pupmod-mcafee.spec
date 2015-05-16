Summary: McAfee Puppet Module
Name: pupmod-mcafee
Version: 4.1.0
Release: 2
License: Apache License, Version 2.0
Group: Applications/System
Source: %{name}-%{version}-%{release}.tar.gz
Buildroot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires: pupmod-rsync >= 2.0.0-0
Requires: puppet >= 3.3.0
Buildarch: noarch
Requires: simp-bootstrap >= 4.2.0
Obsoletes: pupmod-mcafee-test

Prefix:"/etc/puppet/environments/simp/modules"

%description
This Puppet module provides the capability to install the McAfee command line
virus scanner on your systems.

DAT files are distributed via rsync.

%prep
%setup -q

%build

%install
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/mcafee

dirs='files lib manifests templates'
for dir in $dirs; do
  test -d $dir && cp -r $dir %{buildroot}/%{prefix}/mcafee
done

mkdir -p %{buildroot}/usr/share/simp/tests/modules/mcafee

%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/mcafee

%files
%defattr(0640,root,puppet,0750)
/etc/puppet/environments/simp/modules/mcafee

%post
#!/bin/sh

if [ -d /etc/puppet/environments/simp/modules/mcafee/plugins ]; then
  /bin/mv /etc/puppet/environments/simp/modules/mcafee/plugins /etc/puppet/environments/simp/modules/mcafee/plugins.bak
fi

%postun
# Post uninstall stuff

%changelog
* Fri Jan 16 2015 Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-2
- Changed puppet-server requirement to puppet

* Tue Apr 22 2014 Trevor Vaughan <tvaughan@onyxopint.com> - 4.1.0-1
- Removed all calls to any global variables.

* Sun Mar 02 2014 Kendall Moore <kmoore@keywcorp.com> - 4.1.0-0
- Refactored manifests for hiera and puppet 3 compatibility.
- Added rspec tests for test coverage.

* Mon Feb 25 2013 Maintenance
2.0-5
- Added a call to $::rsync_timeout to the rsync call since it is now required.

* Wed Apr 11 2012 Maintenance
2.0.0-4
- Moved mit-tests to /usr/share/simp...
- Updated pp files to better meet Puppet's recommended style guide.

* Fri Mar 02 2012 Maintenance
2.0.0-3
- Improved test stubs.

* Mon Dec 26 2011 Maintenance
2.0.0-2
- Updated the spec file to not require a separate file list.

* Thu Jan 27 2011 Maintenance
2.0.0-1
- Updated to use rsync native type

* Tue Jan 11 2011 Maintenance
2.0.0-0
- Refactored for SIMP-2.0.0-alpha release

* Tue Oct 26 2010 Maintenance - 1-1
- Converting all spec files to check for directories prior to copy.

* Fri May 21 2010 Maintenance
1.0-0
- Code refactor and Doc update
