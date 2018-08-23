# kubectl help
kubectl controls the Kubernetes cluster manager

### Interact with help...

```bash
kubectl help
kubectl version
```

### Interact with config sub-command

```bash
kubectl config current-context
kubectl config get-contexts
```

### Interact with run sub-command

```bash
kubectl run kubia --image=indrayam/kubia --port=8080
```

### Interact with expose sub-command

```bash
kubectl expose deployment kubia --type=LoadBalancer
```

### Interact with scale sub-command

```bash
kubectl scale deployment kubia --replicas=3
```

### Interact with get sub-command

```bash
kubectl get nodes
kubectl get pods #or, po
kubectl get service #or, svc
kubectl get depolyments #or, deploy
kubectl get replicaset #or, rs
```

### Interact with describe sub-command

```bash
kubectl describe pod <pod-name>
kubectl describe po/<pod-name>
```

### Use explain to discover possible API object fields

```bash
kubectl explain pods
kubectl explain pods.kind
kubectl explain pods.metadata
kubectl explain pods.spec
kubectl explain pods.status
```

### Interact with application manifests

```bash
kubectl create -f filename.yml # -f filename1.yml
kubectl apply -f filename.yml # -f filename1.yml
kubectl delete -f filename.yml # -f filename1.yml
```

### Create User

```bash
{
USER="philip"
GROUP="CoDE"
openssl genrsa -out ${USER}.key 2048 # Get Key
openssl req -new -key ${USER}.key -out ${USER}.csr -subj "/CN=${USER}/O=${GROUP}" # Create a CSR
openssl x509 -req -in ${USER}.csr -CA ./kubernetes.crt -CAkey ./kubernetes.key -CAcreateserial -out ${USER}.crt # Generate Certificate
}
kubectl config set-credentials ${USER} --client-certificate ./${USER}.crt --client-key ./${USER}.key --embed-certs=true
kubectl config set-context ${USER}@k8s-on-p3-rtp --cluster=k8s-on-p3-rtp --user=${USER}
kubectl create namespace ${USER}
kubectl create rolebinding ${USER}-admin --clusterrole admin --group ${GROUP} --namespace ${USER}
```
