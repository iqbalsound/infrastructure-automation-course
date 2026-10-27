package { 'nginx':
  ensure => installed,
}

file { '/var/www/html/index.html':
  ensure  => file,
  content => "Managed by Puppet\n",
  require => Package['nginx'],
}

service { 'nginx':
  ensure   => running,
  provider => 'init',   # no systemd inside a container
  require  => Package['nginx'],
}
