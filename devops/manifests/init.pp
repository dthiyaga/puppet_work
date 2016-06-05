class devops {
    include devops::puppet
    include devops::motd
    include devops::issue_net
    include devops::mounts
    include devops::iscsi

    if $devops_cdc_restricted == 'True' {
        include devops::cdc
    }
}
