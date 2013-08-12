# Public: Install RabbitMQ
#
# Examples
#
#   include rabbitmq
#
class rabbitmq {
  include homebrew
  include erlang

  file { [
    '/opt/boxen/data/rabbitmq',
    '/opt/boxen/log/rabbitmq'
  ]:
    ensure => directory,
  }

  homebrew::formula { 'rabbitmq':
    source => 'puppet:///modules/rabbitmq/brews/rabbitmq.rb',
    before => Package['boxen/brews/rabbitmq'] ;
  }

  file { '/Library/LaunchDaemons/dev.rabbitmq.plist':
    content => template('rabbitmq/dev.rabbitmq.plist.erb'),
    group   => 'wheel',
    notify  => Service['dev.rabbitmq'],
    owner   => 'root'
  }

  package { 'boxen/brews/rabbitmq':
    ensure  => '3.1.4-boxen1',
    notify  => Service['dev.rabbitmq']
  }

  service { 'dev.rabbitmq':
    ensure  => running,
    require => Package['boxen/brews/rabbitmq']
  }

}
