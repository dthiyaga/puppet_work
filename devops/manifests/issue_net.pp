class devops::issue_net {

	case $::operatingsystem {

		/(OEL|OracleLinux|RedHat)/: {
		    file { "/etc/issue.net":
		        owner => "root",
		        group => "root",
		        mode => 644,
		        content => template("devops/motd.erb"),
			}
		}
        default: {
        	info("Module ${module_name} is not needed on ${::operatingsystem}")
        }
    }
}
