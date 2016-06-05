class devops::celery {

    # service { celeryevcam:
    #     ensure => running
    # }

    service { celery:
        ensure => running
    }

   file { "/etc/init.d/celery":
        ensure => symlink,
        target => "/usr/local/django/devops/lib/celery.sh",
    }

   file { "/etc/init.d/celeryevcam":
        ensure => symlink,
        target => "/usr/local/django/devops/lib/celeryevcam.sh",
    }
}
