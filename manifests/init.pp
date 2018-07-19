# See README.md for details.
class duplicity (
  $logdir = '/opt/duplicity/log',
) {
  case $::operatingsystem {
    'Debian', 'Ubuntu': { include ::duplicity::debian }
    'RedHat', 'Centos': { include ::duplicity::redhat }
    default: { fail "${::operatingsystem} not yet implemented for ${name}" }
  }
}
