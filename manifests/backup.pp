# =Definition: duplicity::backup
#
#
define duplicity::backup(
  $destination,
  $ensure              = present,
  $source              = '/',
  $cache_storage_path  = '/opt/duplicity/cache',
  $rules               = [],
  $retention           = '100D',
  $full                = '15D',
  $env_var             = [],
  $volsize             = '200',
  $args                = '',
  $log_level           = '4',
  $encryption_key      = '' ) {

  file { [
    '/opt/duplicity',
    '/opt/duplicity/conf',
    "$cache_storage_path"
  ]:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
  }


  file {"/opt/duplicity/${name}.sh":
    ensure  => $ensure,
    mode    => '0750',
    owner   => 'root',
    group   => 'root',
    content => template('duplicity/backup.erb'),
  }

  file {"/opt/duplicity/conf/${name}.include":
    ensure  => $ensure,
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    content => template('duplicity/backup.include.erb'),
  }

  file {"/opt/duplicity/conf/${name}.exclude":
    ensure  => $ensure,
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    content => template('duplicity/backup.exclude.erb'),
  }

  file { '/opt/duplicity/conf/.env':
    content => template("${module_name}/env.erb"),
    mode    => '0600',
    owner   => 'root',
    group   => 'root',

  }
}
