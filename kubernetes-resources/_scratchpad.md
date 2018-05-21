### Create Deployment, ReplicaSet, Pods (using kubectl)

Creates deployment, replicaset and pods:
`k run nginx --image=nginx --port=80`
`k run kubia --image=luksa/kubia --port=8080`
`k run hello-world --replicas=2 –labels=“run=load-balancer-example” --image=gcr.io/google-samples/node-hello:1.0 --port=8080`

### Create Service (using kubectl)

Creates a Service of type NodePort, as well as corresponding Endpoint:
`k expose deploy/kubia --name=kubia-svc --type=NodePort --port=8080 --target-port=80`
`k get svc/kubia`
`k get ep`

### Delete Kubernetes Resources (using kubectl)

`k delete svc/kubia-svc`

### Port forward into a Pod (using kubectl)

The first port is the local port. The second port is the container port
`k port-forward nginx-web-75b97d786d-6mzjx 8080:80`

In order to access the service, use:
`curl node-ip:nodeport`

In order to access the service from Minikube cluster, use:
`minikube service nginx-svc`
OR
`minikube service nginx-svc --url`

