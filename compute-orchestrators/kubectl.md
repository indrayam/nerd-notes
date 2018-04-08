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

### Kubectl Resource Type

* componentstatuses (cs)
* nodes
* pods (po)
  - podsecuritypolicies
  - podpreset
  - podtemplates
  - poddisruptionbudget
* namespaces (ns)
* deployments (deploy)
* replicasets (rs)
* replicacontrollers (rc)
* services (svc)
* endpoints (ep)
* ingresses (ing)
* configmaps (cm)
* secrets
* persistentvolumes (pv)
* persistentvolumeclaims (pvc)
* statefulsets (sts)
* daemonsets (ds)
* jobs
* cronjobs
* serviceaccount (sa)
* roles
* rolebindings
* clusterroles
* clusterrolebindings 
* certificatesigningrequests (csr)
* customresourcedefinition (crd)
* events (ev)
* horizontalpodautoscalers (hpa)
* resourcequotas (quota)
* limitranges (limits)
