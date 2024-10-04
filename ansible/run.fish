#!/opt/local/bin/fish
argparse --ignore-unknown p/playbook= -- $argv
or return

set -x NO_PROXY "*"
set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES
set -x ANSIBLE_HOST_KEY_CHECKING False
set ANSIBLE_COMMAND ansible-playbook -i inventories/core.yml playbook-core.yml

switch $_flag_p
    case 'run'
        $ANSIBLE_COMMAND $argv
    case 'reload-proxy'
        $ANSIBLE_COMMAND -l proxy --start-at-task "Configure the Squid Proxy" \
            -e server_proxy_reload_only=true $argv
    case 'reload-ns'
        $ANSIBLE_COMMAND -l ns --start-at-task "Create/Update the NS Records" \
            -e server_ns_create_zone=true $argv
end