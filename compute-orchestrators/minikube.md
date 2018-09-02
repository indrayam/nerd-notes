# minikube commands

Create an alias called `mk` for `minikube`

[Error starting Minikube](https://github.com/kubernetes/minikube/issues/2755#issuecomment-385624552)

If you get an error starting Minikube, check the github comment linked above. Basically, run `mk delete` and reinstall the cluster `mk start`. Things should start working

### Minikube Help
mk help

### Get the version of minikube running
mk version

### Check for an update
mk update-check

### Start a local kubernetes cluster
mk start

### Get the kubernetes URL(s) for the specified service in your local cluster
mk service <service-name> --url

### Stop a running local kubernetes cluster
mk stop

### Check addons
mk addons list

### Get Kubernetes Versions
mk get-k8s-versions


