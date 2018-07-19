# =Definition: duplicity::backup
#
#
define duplicity::backup(
  $destination,
  $ensure         = present,
  $source         = '/',
  $rules          = [],
  $retention      = '90D',
  $full           = '15D',
  $env_var        = [],
  $volsize        = '200',
  $args           = '',
  $encryption_key = '') {

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
