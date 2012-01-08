import "polipo.pp"
import "daemon.pp"
import "relay.pp"
import "bridge.pp"

class tor {
  package { "privoxy":
    ensure => absent,
  }

  package { [ "tor", "torsocks" ]:
    ensure => installed,
    require => File["/var/tor"],
  }

  group { "debian-tor":
    ensure    => present,
    allowdupe => false,
  }

  user { "debian-tor":
    allowdupe => false,
    comment   => "tor user,,,",
    ensure    => present,
    home      => "/var/tor",
    shell     => "/bin/sh",
    gid       => "debian-tor",
    require   => Group["debian-tor"], 
  }

  file { "/var/tor":
    ensure  => directory,
    mode    => 0755,
    owner   => debian-tor,
    group   => debian-tor,
    require => User["debian-tor"],
  }
}
