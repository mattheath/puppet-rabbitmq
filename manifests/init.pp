# Public: Install RabbitMQ
#
# Examples
#
#   include rabbitmq
#
class rabbitmq {
  include homebrew
  include erlang

  homebrew::formula { 'rabbitmq':
    source => 'puppet:///modules/rabbitmq/brews/rabbitmq.rb',
    before => Package['boxen/brews/rabbitmq'] ;
  }

  package { 'boxen/brews/rabbitmq':
    ensure  => '3.1.4-boxen1'
  }

}
