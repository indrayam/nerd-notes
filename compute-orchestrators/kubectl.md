# kubectl help
kubectl controls the Kubernetes cluster manager

### kubectl run

`kubectl run NAME [OPTIONS] -- [COMMAND] [args]`

where,

- `--rm` If true, delete resources created in this command for attached containers
- `--tty | -t` Allocated a TTY for each container in the pod
- `--stdin | -i` Keep stdin open on the container(s) in the pod, even if nothing is attached
- `--image` The image name for the container to run
- `--env` List of environment variables 
- `--` Separator to run command
- `[COMMAND] [args]` Command to run inside the container

```bash
# Spin up an instance
kubectl run test-$RANDOM --rm -i -t --image alpine -- ash
kubectl run test-$RANDOM --rm -i -t --image ubuntu:16.04 -- bash
kubectl run test-$RANDOM --rm -i -t --image indrayam/debug-container:latest -- bash

kubectl run httpd --image httpd --replicas 3
kubectl expose deploy httpd --port 8080 --target-port 80 --type NodePort

kubectl run nginx --image nginx --replicas 3
kubectl expose deploy nginx --port 8081 --target-port 80 --type NodePort

kubectl run mongo --image mongo
kubectl expose deploy mongo --port 27017 --type NodePort

kubectl run redis --image redis 
kubectl expose deploy redis --port 6379 --type NodePort

kubectl run postgres --image postgres --env POSTGRES_PASSWORD=test1234
kubectl expose deploy postgres --port 5432 --type NodePort

kubectl run mariadb --image mariadb --env MYSQL_ROOT_PASSWORD=test1234
kubectl expose deploy mariadb --port 3306 --type NodePort



```

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
USER="anand"
GROUP="CoDE"
CLUSTER="play"
openssl genrsa -out ${USER}.key 2048 # Get Key
openssl req -new -key ${USER}.key -out ${USER}.csr -subj "/CN=${USER}/O=${GROUP}" # Create a CSR
openssl x509 -req -in ${USER}.csr -CA ${CLUSTER}.crt -CAkey ${CLUSTER}.key -CAcreateserial -out ${USER}.crt # Generate Certificate
kubectl config set-credentials ${USER}-rtp-${CLUSTER} --client-certificate ${USER}.crt --client-key ${USER}.key --embed-certs=true
kubectl config set-context ${USER}@k8s-on-p3-rtp-${CLUSTER} --cluster=k8s-on-p3-rtp-${CLUSTER} --user=${USER}-rtp-${CLUSTER}
kubectl create namespace ${USER}
kubectl create rolebinding ${USER}-admin --clusterrole admin --group ${GROUP} --namespace ${USER}
#kubectl create rolebinding tiller-admin --clusterrole admin --group CoDE --namespace tiller-code
}
```
