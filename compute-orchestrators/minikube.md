# minikube commands

Create an alias called `mk` for `minikube`

## Installation Errors

1. [Error starting Minikube](https://github.com/kubernetes/minikube/issues/2755#issuecomment-385624552)

If you get an error starting Minikube, check the github comment linked above. Basically, run `mk delete` and reinstall the cluster `mk start`. Things should start working

2. In case you get an "time out" error related to 192.168.99.100, run the following commands to make sure you have both a network interface called `vboxnet0` and a corresponding route in the IP route table

- `ip addr` should show you an entry for vboxnet0 like the following:

```bash
vboxnet0: flags=8943<UP,BROADCAST,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
    ether 0a:00:27:00:00:00
    inet 192.168.99.1/24 brd 192.168.99.255 vboxnet0
```

- `ip route` should show you an entry for 192.168.99.0 like the following:

```bash
192.168.99.0/24 dev vboxnet  scope link
```

Chances are you will see one, but not both, if you are getting timeout errors. If so, uninstalling VirtualBox, Minikube and restarting the laptop cleared the `ip addr` entry. Reinstalling the VM followed by Minikube showed both these entries come up again. Once that happens, the timeout error should disappear

I am sure there is a way to manually add the route using `ip route` or `ip link` commands as shown in this article: [Can't connect to minikube (virtualbox) all of a sudden?](https://www.reddit.com/r/kubernetes/comments/6rt18h/cant_connect_to_minikube_virtualbox_all_of_a/)

3. We noticed a pattern where turning on VPN deleted the `192.168.99.0/24 dev vboxnet  scope link` entry from `ip route` command. In order to get around this, we had to run the following command to make minikube work again:

```bash
sudo route -nv add -net 192.168.99.0/24 -interface vboxnet0
```


### Minikube Help
mk help

### Get the version of minikube running
mk version

### Setup Docker Environment variables
mk docker-env
# Usually used like this: eval $(minikube docker-env)

### Check for an update
mk update-check

### Start a local kubernetes cluster
mk start
minikube start --memory=8192 --cpus=4 --kubernetes-version=v1.10.0 \
    --extra-config=controller-manager.cluster-signing-cert-file="/var/lib/localkube/certs/ca.crt" \
    --extra-config=controller-manager.cluster-signing-key-file="/var/lib/localkube/certs/ca.key" \
    --vm-driver='virtualbox'
minikube start --memory='2000mb' --cpus=2 --vm-driver=virtualbox

### Get the kubernetes URL(s) for the specified service in your local cluster
mk service <service-name> --url

### Stop a running local kubernetes cluster
mk stop

### Check addons
mk addons list

### Get Kubernetes Versions
mk get-k8s-versions


