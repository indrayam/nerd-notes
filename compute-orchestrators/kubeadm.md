# kubeadm

## Install a specific version of kubeadm etc.

```bash
apt-get install -y kubelet=1.11.2-00 kubeadm=1.11.2-00 kubectl=1.11.2-00 kubernetes-cni=0.6.0-00
```

## Print the join command for a new node

[Reference](https://linuxacademy.com/community/posts/show/topic/25431-tip-kubeadm-print-join-command)

```bash
sudo kubeadm token create --print-join-command
```

## Delete Nodes from Cluster (if necessary)

```bash
kubectl delete node learn-k8s-node-4
kubectl delete node learn-k8s-node-5
```

## Upgrade Cluster installed using kubeadm

1. Upgrade Master Node

```bash
sudo apt-get update
sudo apt-get upgrade -y kubelet kubeadm
kubeadm version # Check that you now have the latest version
sudo kubeadm upgrade plan
sudo kubeadm upgrade apply v1.12.2
kubectl get nodes -o wide
```

At this stage, you should see your master node updated, but the rest of the nodes are not. Before you continue, upgrade your Software Defined Network (SDN). In my case, since I use Weave, it can now be upgraded by running the following command:

```bash
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```

2. Drain all Nodes (Master and Worker Nodes)

Run these commands from master. Replace $NODE with the name of the node(s)

```bash
kubectl drain play-k8s-control-plane --ignore-daemonsets
kubectl drain play-k8s-node-1 --ignore-daemonsets --delete-local-data
kubectl drain play-k8s-node-2 --ignore-daemonsets --delete-local-data
kubectl drain play-k8s-node-3 --ignore-daemonsets --delete-local-data
...
```

3. Upgrade the Kubernetes package version on each $NODE node by running the Linux package manager for your distribution:

```bash
sudo apt-get update
sudo apt-get upgrade -y kubelet kubeadm
```

4. Upgrade kubelet on each node

```bash
sudo kubeadm upgrade node config --kubelet-version $(kubelet --version | cut -d ' ' -f 2)
sudo systemctl restart kubelet
sudo systemctl status kubelet
```

5. Uncordon each node

```bash
kubectl uncordon play-k8s-control-plane
kubectl uncordon play-k8s-node-1
kubectl uncordon play-k8s-node-2
kubectl uncordon play-k8s-node-3
...
```

