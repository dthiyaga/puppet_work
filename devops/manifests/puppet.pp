class devops::puppet {
    file { "/usr/local/pdit/bin/puppet-apply":
        mode => 500,
        owner => root,
        group => root,
        source => "puppet:///modules/devops/bin/puppet-apply"
    }

    $minute = fqdn_rand(60)
    cron { "cron.puppet.apply":
        command => "/usr/local/pdit/bin/puppet-apply > /dev/null 2>&1",
        user => "root",
        minute => $minute,
        require => File["/usr/local/pdit/bin/puppet-apply"],
    }
}
