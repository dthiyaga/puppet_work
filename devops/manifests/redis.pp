class devops::redis {

    group { "redis":
        ensure => present,
    }

    user { "redis":
        ensure => present,
        gid => "redis",
    }

    service { redis:
        ensure => running
    }

   file { "/etc/init.d/redis":
        ensure => symlink,
        target => "/usr/local/django/devops/lib/redis.sh",
    }

}
