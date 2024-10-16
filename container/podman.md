# podman

## Mac installation

```bash
brew install podman
```

Instantiate the podman machine (basically a fedora VM)

```bash
podman machine init
podman machine start
```

Post installation Notes:

```bash
Starting machine "podman-machine-default"

This machine is currently configured in rootless mode. If your containers
require root permissions (e.g. ports < 1024), or if you run into compatibility
issues with non-podman clients, you can switch using the following command:

	podman machine set --rootful

API forwarding listening on: /var/folders/7k/hl3qdmx559v5ksk7g_slsd7w0000gn/T/podman/podman-machine-default-api.sock

The system helper service is not installed; the default Docker API socket
address can't be used by podman. If you would like to install it, run the following commands:

        sudo /opt/homebrew/Cellar/podman/5.2.4/bin/podman-mac-helper install
        podman machine stop; podman machine start

You can still connect Docker API clients by setting DOCKER_HOST using the
following command in your terminal session:

        export DOCKER_HOST='unix:///var/folders/7k/hl3qdmx559v5ksk7g_slsd7w0000gn/T/podman/podman-machine-default-api.sock'

Machine "podman-machine-default" started successfully
```

## Final installation step

```bash
sudo /opt/homebrew/Cellar/podman/5.2.4/bin/podman-mac-helper install
podman machine stop
podman machine set --rootful
podman machine start
```
## Uninstall podman

```bash
brew uninstall podman
rm -rf ~/.config/containers/
rm -rf ~/.local/share/containers
rm -rf $TMPDIR/podman
rm -f ~/.ssh/podman*
```
## podman machine

```bash
podman machine list
podman machine info
podman machine ssh
#cat /etc/redhat-release
```