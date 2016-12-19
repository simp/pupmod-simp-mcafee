# == Class mcafee
#
# This class installed the command line McAfee anti-virus scanner and
# configures updates to be pulled from rsync.
#
# If you wish to schedule a virus scan, you will need to create a cron job
# that is appropriate, or drop a script into the cron.* directory that is
# appropriate.
#
# == Parameters
#
# @param rsync_source[String]
# @param rsync_server[String]
# @param rysnc_timeout[Stdlib::Compat::Integer]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class mcafee(
  String                   $rsync_source  = "mcafee_${::environment}/",
  String                   $rsync_server  = simplib::lookup('simp_options::rsync::server', { 'default_value'  => '127.0.0.1'}),
  Stdlib::Compat::Integer  $rsync_timeout = simplib::lookup('simp_options::rsync::timeout', { 'default_value' => '2' })
){

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
