# See README.md for details.
class duplicity::common (
  $logdir_group,
  $cron_hour   = fqdn_rand(6),
  $cron_minute = fqdn_rand(60),
) {

  package {'duplicity':
    ensure => present,
  }

  file {$duplicity::logdir :
    ensure => directory,
    owner  => 'root',
    group  => $logdir_group,
    mode   => '0750',
  }

  tidy {$duplicity::logdir :
    age     => '4W',
    recurse => true,
    matches => '*.log',
  }
  file { [
    '/opt/duplicity',
    '/opt/duplicity/conf',
    '/opt/duplicity/cache'
  ]:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
  }

  $module_path = get_module_path($module_name)
  file {'/opt/duplicity/duplicity-backups.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    content => file("${module_path}/files/duplicity-backups.sh"),
  }

  cron {'duplicity backups':
    ensure  => present,
    minute  => $cron_minute,
    hour    => $cron_hour,
    command => 'nice /opt/duplicity/duplicity-backups.sh',
  }
}
