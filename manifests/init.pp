# == Class mcafee
#
# This class installed the command line McAfee anti-virus scanner and
# configures updates to be pulled from rsync.
#
# If you wish to schedule a virus scan, you will need to create a cron job
# that is appropriate, or drop a script into the cron.* directory that is
# appropriate.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class mcafee(
  $rsync_source = "mcafee_${environment}/",
  $rsync_server = hiera('rsync::server'),
  $rsync_timeout = hiera('rsync::timeout','2')
){

  validate_string($rsync_server)
  validate_integer($rsync_timeout)

  case $::hardwaremodel {
    'x86_64': {
      $mcafee_package = 'mcafee-uvscan64'
    }
    default: {
      $mcafee_package = 'mcafee-uvscan32'
    }
  }

  package { $mcafee_package: ensure => 'latest' }

  file { '/opt/mcafee_dat':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    recurse => true,
    require => Package[$mcafee_package]
  }

  rsync { 'mcafee':
    source  => $rsync_source,
    target  => '/opt/mcafee_dat',
    server  => $rsync_server,
    timeout => $rsync_timeout,
    delete  => true
  }
}
