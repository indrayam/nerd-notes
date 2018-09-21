### Create Deployment, ReplicaSet, Pods (using kubectl)

__Creates deployment, replicaset and pods:__

```bash
k run nginx --image=nginx --port=80
k run kubia --image=luksa/kubia --port=8080
k run hello-world --replicas=2 –labels="run=load-balancer-example" --image=gcr.io/google-samples/node-hello:1.0 --port=8080
```

__Creates a Service of type NodePort, as well as corresponding Endpoint:__

```bash
k expose deploy/kubia --name=kubia-svc --type=NodePort --port=8080 --target-port=80
k get svc/kubia
k get ep
```

__Delete Kubernetes Resources (using kubectl):__

```bash
k delete deploy/kubia svc/kubia-svc
```

__Port forward into a Pod (using kubectl):__

The first port is the local port. The second port is the container port

```bash
k port-forward nginx-web-75b97d786d-6mzjx 8080:80
```

In order to access the service, use: `curl node-ip:nodeport`

In order to access the service from Minikube cluster, use: 

`minikube service nginx-svc`

OR

`minikube service nginx-svc --url`

__Port forward Setup to Access k8s dashboard:__

```bash
kubectl proxy --port 8011
open http://localhost:8011/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```

```bash
k get secret spinnaker-gate-tls -o jsonpath='{.data.tls\.crt}' | base64 --decode > ca.crt
```

__Prerequisites for using RBAC on GKE__

You must grant your user the ability to create roles in Kubernetes by running the following command. [USER_ACCOUNT] is the user's email address:

```bash
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user "anand.sharma@gmail.com"
```

__How do you grant kubectl access to a Service Account__

```bash
# Switch to the right namespace where you want to create a Service Account. For example: httpbin
# Create a Service account
kubectl create sa codedeveloper

# Map the appropriate role in the appropriate namespace(s)
kubectl create rolebinding httpbin-admin --clusterrole admin --serviceaccount httpbin:codedeveloper --namespace httpbin
kubectl create rolebinding code-demo-apps-admin --clusterrole admin --serviceaccount httpbin:codedeveloper --namespace code-demo-apps

# Check if it all looks good
kubectl get rolebinding httpbin-admin -o yaml

# See the base64 encoded token value
kubectl get secret codedeveloper-token-vx55v --namespace httpbin -o yaml

# [OPTIONAL] Use k8sec to see the base64 decoded value, if you have it installed
k8sec list

# Set .kube/config settings
kubectl config set-credentials codedeveloper-sa --token=$(kubectl get secret codedeveloper-token-vx55v -o jsonpath={.data.token} | base64 -d)
kubectl config set-context codedeveloper-ctx --user=codedeveloper-sa

# Open .kube/config and copy the cluster value into the context
```
