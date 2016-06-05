# This is for machines that are located in CDC (China).
# There are special rules regarding these machines.

class devops::cdc {
	# Disable NIS:
  # Keep this code section disabled until LDAP can handle this access issue.
	#service { "ypbind":
  #      ensure => stopped,
  #      enable => false,
  #  }
	#service { "ypserv":
  #      ensure => stopped,
  #      enable => false,
  #  }
	
	# Create local account for owner:
    user { "<%= devops_user_short %>":
        ensure => present,
        gid => "<%= devops_user_short %>",
    }
	
	# Create 'cdctest' local account:  
    user { "cdctest":
        ensure => present,
        gid => "cdctest",
    }
    
}
