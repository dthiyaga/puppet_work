class devops::beanstalkd {

    group { "beanstalkd":
        ensure => present,
    }

    user { "beanstalkd":
        ensure => present,
        gid => "beanstalkd",
    }

    file { "/usr/local/pdit/etc/sysconfig/beanstalkd":
        mode => 500,
        owner => root,
        group => root,
        source => "puppet:///modules/devops/etc/sysconfig/beanstalkd",
        notify => Service[beanstalkd],
    }

    service { beanstalkd:
        ensure => running
    }

    file { "/var/lib/beanstalkd/binlog":
        ensure => directory,
        mode => 700,
        owner => beanstalkd,
        group => beanstalkd,
        recurse => true,
    }

}
