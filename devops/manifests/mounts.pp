class devops::mounts {

    define devops_mount($path) {
        $mountpoint = "/mnt/devops_${name}"

        # We get passed 'None' if it should be not used.
        if $path == 'None' {
            info("Unmounting: ${mountpoint}")
            file{ $mountpoint:
                ensure => 'absent',
                require => Mount[$mountpoint],
                backup => false,
                force => true,
            }
            mount { $mountpoint:
                ensure => 'absent'
            }
        } else {
            info("Mounting: ${mountpoint}:${path}")
            file{ $mountpoint:
                ensure => directory,
                mode => 0755,
            }
            file{ "$mountpoint/public":
                ensure => directory,
                mode => 0777,
                owner => root,
                group => root,
                require => Mount[$mountpoint],
            }
            file { "$mountpoint/dba":
                ensure => directory,
                mode => 0775,
                owner => root,
                group => dba,
                require => Mount[$mountpoint],
            }
            file { "$mountpoint/root":
                ensure => directory,
                mode => 0700,
                owner => root,
                group => root,
                require => Mount[$mountpoint],
            }
            file { "$mountpoint/readme.txt":
                ensure => file,
                mode => 0444,
                owner => root,
                group => root,
                source => "puppet:///modules/devops/mount_readme.txt",
                require => Mount[$mountpoint],
            }
            mount { $mountpoint:
                device => $path,
                fstype => 'nfs',
                ensure => 'mounted',
                options => 'nfsvers=3,rw,bg,hard,wsize=32768,rsize=32768', # Needed for DBs I'm told.
                atboot => true,
                require => File[$mountpoint],
                blockdevice => '-'
            }
        }
    }

    file { "/mnt":
        ensure => directory,
        mode => 0755,
    }

    # Someone explain to me again how amazing Puppet is with no 'for' operator? --Ash
    if $devops_managed == 'True' {
        devops_mount{0: path => $devops_mount_0}
        devops_mount{1: path => $devops_mount_1}
        devops_mount{2: path => $devops_mount_2}
        devops_mount{3: path => $devops_mount_3}
        devops_mount{4: path => $devops_mount_4}
        devops_mount{5: path => $devops_mount_5}
        devops_mount{6: path => $devops_mount_6}
        devops_mount{7: path => $devops_mount_7}
        devops_mount{8: path => $devops_mount_8}
        devops_mount{9: path => $devops_mount_9}
    }
}
