# See README.md for details.
class duplicity::debian (
  $cron_hour    = fqdn_rand(6),
  $cron_minute  = fqdn_rand(60),
  $logdir_group = 'adm',
) {
  class { '::duplicity::common':
    cron_hour    => $cron_hour,
    cron_minute  => $cron_minute,
    logdir_group => $logdir_group,
  }
}
