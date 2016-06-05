class devops::iscsi {
	file { "/etc/iscsi":
        owner => "root",
        group => "root",
        mode => 0755,
		ensure => directory,
	}

    file { "/etc/iscsi/initiatorname.iscsi":
		ensure => symlink,
        target => "/etc/initiatorname.iscsi",
        require => File["/etc/iscsi"],
    }

    file { "/etc/initiatorname.iscsi":
        owner => "root",
        group => "root",
        mode => 0644,
        content => "InitiatorName=iqn.1988-12.com.oracle.${::hostname}\n"
	}
}
