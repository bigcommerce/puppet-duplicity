# See README.md for details.
class duplicity::uninstall::debian {
  package {'duplicity':
    ensure => purged,
  }

  file {'/opt/duplicity/':
    ensure  => absent,
    purge   => true,
    force   => true,
    recurse => true,
    backup  => false,
  }

  file {$duplicity::logdir :
    ensure  => absent,
    purge   => true,
    force   => true,
    recurse => true,
    backup  => false,
  }

  cron {'duplicity backups':
    ensure  => absent,
    minute  => fqdn_rand(60),
    hour    => fqdn_rand(6),
    command => '/opt/duplicity/duplicity-backups.sh',
  }
}
