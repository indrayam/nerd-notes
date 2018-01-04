# lxc

- `sudo lxc-ls --fancy` Fancy listing of LXC containers
- `sudo lxc-ls --active` Listing of containers that are active
- `sudo lxc-create -n <name> -t <template> -- -d <distribution-name (centos)> -r <release-name (7)> -a <architecture-name (amd64)>` Create a container
- `sudo lxc-start -n <name> -d` Start a container
- `sudo lxc-stop -n <name>` Stop a container
- `sudo lxc-destroy -n <name>` Destroy the container
- `sudo lxc-console -n <name> -t 0` Console login into the container
- `sudo lxc-attach -n <name>` Attach to the container
- `sudo lxc-info -n <name>` Get info about the container
