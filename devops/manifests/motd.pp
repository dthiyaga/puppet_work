class devops::motd {
	if $devops_use == false {
		$motd_opt_out = 'False'
	} else {
		case $devops_use {
			/no_puppet/: {
				$motd_opt_out = 'True'
			}
			default: {
				$motd_opt_out = 'False'
			}
		}
	}

	debug ("motd_opt_out = $motd_opt_out")

	if ($motd_opt_out == 'False'){
	    file { "/etc/motd":
	        owner => "root",
	        group => "root",
	        mode => 644,
	        content => template("devops/motd.erb"),
	    }
	} else {
		info("user opted out - skipping /etc/motd management")
	}
}
