# Notes on setting up Kubernetes cluster

### Running on Managed Kubernetes Clusters 

```
kubectl run hello-app --image gcr.io/google-samples/hello-app:1.0 --replicas 3 --port 8080
kubectl expose deployment hello-app --type "LoadBalancer"
oc login https://api.pro-us-east-1.openshift.com --token=nl7qyZPB2S5RBxIewpVhL0JfNQTw8JTtu57bCw1BZO0
az aks create --resource-group SEAZ --name az-anand-cluster --node-count 1 --generate-ssh-keys
az aks get-credentials --resource-group SEAZ --name az-anand-cluster
az aks upgrade -n az-anand-cluster -g SEAZ -k 1.8.7
az aks get-credentials --resource-group SEAZ --name az-anand-cluster — f "="
```

### Setting up your own Kubernetes Cluster 

```
export REGION="nyc1"
export SSH_KEY="..."
```

#### VMs

```
doctl compute tag create k8s-master
doctl compute tag create k8s-node

doctl compute firewall create --name k8s-node --tag-names k8s-node --inbound-rules "protocol:tcp,ports:22,address:0.0.0.0/0 protocol:tcp,ports:all,load_balancer_uid:4657ceb3-7eba-44ea-9395-c81b7be2ad3d protocol:tcp,ports:all,tag:k8s-master protocol:udp,ports:1194,address:0.0.0.0/0" --outbound-rules "protocol:tcp,ports:all,address:0.0.0.0/0 protocol:udp,ports:all,address:0.0.0.0/0"

doctl compute firewall create --name k8s-master --tag-names k8s-master --inbound-rules "protocol:tcp,ports:22,address:0.0.0.0/0 protocol:tcp,ports:all,tag:k8s-node protocol:tcp,ports:443,address:0.0.0.0/0 protocol:tcp,ports:6443,address:0.0.0.0/0 protocol:udp,ports:1194,address:0.0.0.0/0" --outbound-rules "protocol:tcp,ports:all,address:0.0.0.0/0 protocol:udp,ports:all,address:0.0.0.0/0"

doctl compute droplet create k8s-master --region $REGION --image ubuntu-16-04-x64 --size 4gb --tag-name k8s-master --ssh-keys $SSH_KEY --user-data-file ~/.do/bootstrap.sh --wait
doctl compute droplet create k8s-node1 k8s-node2 --region $REGION --image ubuntu-16-04-x64 --size 2gb --tag-name k8s-node --ssh-keys $SSH_KEY --user-data-file ~/.do/bootstrap.sh --wait
doctl compute droplet create k8s-node3 k8s-node4 --region $REGION --image ubuntu-16-04-x64 --size 2gb --tag-name k8s-node --ssh-keys $SSH_KEY --user-data-file ~/.do/bootstrap.sh --wait
```

#### Setting up Kubernetes Master

```
export TOKEN=f7feeb.903016f88bd8272f
apt-get update && apt-get upgrade -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update -y

apt-get install -y docker.io
apt-get install -y --allow-unauthenticated kubelet kubeadm kubectl kubernetes-cni

export MASTER_IP=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
kubeadm init --pod-network-cidr=10.244.0.0/16  --apiserver-advertise-address $MASTER_IP --token $TOKEN

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl create -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml --namespace=kube-system
```

#### Setting up Kubernetes Worker(s)

```
export TOKEN=f7feeb.903016f88bd8272f
export MASTER_IP=162.243.165.32
apt-get update && apt-get upgrade -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update -y
apt-get install -y docker.io
apt-get install -y kubelet kubeadm kubectl kubernetes-cni
kubeadm join --token f7feeb.903016f88bd8272f 162.243.165.32:6443 --discovery-token-ca-cert-hash sha256:3b41d2751c62dd08ee6dc168a9fa55d709821ef74fc3f9f1da8c92f4045f72b7
```

#### Setting up Load Balancer
export NODEPORT="30023"
doctl compute load-balancer create --name do-anand-cluster-self-slb --tag-name k8s-node --region nyc1 --health-check protocol:http,port:$NODEPORT,path:/,check_interval_seconds:10,response_timeout_seconds:5,healthy_threshold:5,unhealthy_threshold:3 --forwarding-rules entry_protocol:TCP,entry_port:80,target_protocol:TCP,target_port:$NODEPORT


#### Miscellaneous Commands

Finding the PID of the process using a specific port?
```
sudo netstat -nlp | grep :30023
OR
sudo lsof -n -i :80 | grep LISTEN
```



