# kubectl help
kubectl controls the Kubernetes cluster manager

### Interact with help...

```bash
kubectl help
kubectl version
```

### Interact with get sub-command

```bash
kubectl get pods
kubectl get nodes
kubectl get service
kubectl get depolyments
kubectl get ingress
kubectl get clusterrolebindings
```

### Interact with config sub-command

```bash
kubectl config current-context
kubectl config get-contexts
```

### Interact with run sub-command

```bash
kubectl run hello-web --image=gcr.io/google-samples/hello-app:1.0 --port=8080
kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.4 --port=8080
```

### Interact with expose sub-command

```bash
kubectl expose deployment hello-web --type=LoadBalancer
kubectl expose deployment hello-minikube --type=NodePort
```

### Interact with scale sub-command

```bash
kubectl scale rs/hello-web --replicas=2
```

### Interact with application manifests

```bash
kubectl create -f <filename>.yml [-f <filename>.yml]
kubectl apply -f <filename>.yml [-f <filename>.yml]
kubectl delete -f <filename.yml> [-f <filename>.yml]
```

### Interact with describe sub-command

```bash
kubectl describe pod <pod-name>
kubectl describe po/<pod-name>
```

