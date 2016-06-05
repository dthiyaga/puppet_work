# This is for machines that are part of the Devops cluster.
# Touching this file without Ash's permission would be very unwise.

class devops::server {
    import "xinetd"

    service { "xinetd":
        ensure => running,
        enable => true,
    }

    xinetd::service {"rsync":
        port => 873,
        server => "/usr/bin/rsync",
        user => root,
        group => root,
        server_args => "--daemon --config /etc/rsyncd.conf",
    }

    file { "/var/log/devops":
        ensure => directory,
        mode => 640,
        owner => apache,
        group => apache,
        recurse => true,
    }

#    file { "/etc/logrotate.d/devops":
#        mode => 644,
#        owner => root,
#        group => root,
#        source => "puppet:///modules/devops/logrotate.d/devops"
#    }

    file { "/var/run/devops":
        ensure => directory,
        mode => 700,
        owner => apache,
        group => apache,
        recurse => true,
    }

    include devops::redis
#    include devops::celery

    file { "/etc/init.d/devops":
        ensure => symlink,
        target => "/usr/local/django/devops/lib/devops.initd"
    }

#    cron { "devops.logs":
#        command => "/usr/bin/find /var/log/django -type f -ctime 5 -exec rm \{\} \;",
#        user => "root",
#        minute => 0,
#        hour => 3,
#    }

}
