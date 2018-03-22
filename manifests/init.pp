# Install the command line McAfee anti-virus scanner and configures updates to
# be pulled from rsync.
#
# If you wish to schedule a virus scan, you will need to create a cron job that
# is appropriate, or drop a script into the cron.* directory that is
# appropriate.
#
# @param rsync_source
# @param rsync_server
# @param rysnc_timeout
#
# @author Trevor Vaughan <tvaughan@onyxpoint.com>
#
class mcafee(
  String        $rsync_source  = "mcafee_${::environment}/",
  Simplib::Host $rsync_server  = simplib::lookup('simp_options::rsync::server', { 'default_value'  => '127.0.0.1'}),
  Integer       $rsync_timeout = simplib::lookup('simp_options::rsync::timeout', { 'default_value' => 2 })
){

  simplib::assert_metadata($module_name)

  case $facts['hardwaremodel'] {
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
