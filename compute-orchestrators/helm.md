# Helm

### Install Helm Client

```bash
brew install kubernetes-helm
```

To configure Helm client, but not install Tiller, do the following:

```bash
helm init --client-only
```

### Tiller Installation to play with (Not secure)

1. Save the following in a YAML file (in this `sa-with-permissions.yaml`)

```bash
apiVersion: v1
kind: Namespace
metadata:
  name: tiller-code
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: tiller-code
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: tiller-code
```

2. Create it against the cluster you want to install Helm in

```bash
kubectl create -f sa-with-permissions.yaml
```

3. Install Tiller

First the dry run to make sure it all looks good!

```bash
helm init \
  --dry-run --debug \
  --override 'spec.template.spec.containers[0].command'='{/tiller,--storage=secret}' \
  --tiller-namespace=tiller-code \
  --service-account=tiller
```

If so, run this

```bash
helm init \
  --override 'spec.template.spec.containers[0].command'='{/tiller,--storage=secret}' \
  --tiller-namespace=tiller-code \
  --service-account=tiller
```

### Secure Installation of Helm

**Sources:**

- [Using SSL Between Helm and Tiller](https://docs.helm.sh/using_helm/#using-ssl-between-helm-and-tiller)
- [Exploring The Security Of Helm](https://engineering.bitnami.com/articles/helm-security.html)

**Assumption:**

In order to secure the Tiller installation on Kubernetes, the following steps was performed:

- Kubernetes Cluster has RBAC enabled. FWIW, all recent `kubeadm` powered Kubernetes Cluster installation come with RBAC enabled
- Deployed Tiller in its own namespace (`tiller-code`) other than `kube-system` and configured the permissions so that Tiller is restricted to deploying resources in well-defined list of namespace(s). In this example, I use the `anand` namespace
- All Release Information stored by Tiller will be stored as a Kubernetes Secret, and not Kubernetes ConfigMap
- Use the `--tiller-tls-verify` option with helm init and the `--tls` flag with other Helm commands to enforce verification

1. Create a namespace to host Tiller

```bash
kubectl create namespace tiller-code
```

2. Create a ServiceAccount in that namespace

```bash
kubectl create serviceaccount tiller --namespace tiller-code
```

3. Create a Role and RoleBinding in the namespace where you want Tiller to install software

The Role

```bash
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: tiller-manager
  namespace: anand
rules:
- apiGroups: ["", "extensions", "apps", "batch"]
  resources: ["*"]
  verbs: ["*"]
```

The RoleBinding

```bash
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: tiller-binding
  namespace: anand
subjects:
- kind: ServiceAccount
  name: tiller
  namespace: tiller-code
roleRef:
  kind: Role
  name: tiller-manager
  apiGroup: rbac.authorization.k8s.io
```

4. Create a Role and RoleBinding in the namespace where Tiller is installed

The Role. I was supposed to give access only to ConfigMaps resource. I gave it all. Did not see why that would be a problem, since this is namespace where Tiller is installed

```bash
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  namespace: tiller-code
  name: tiller-manager
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["*"]
  verbs: ["*"]
```

The RoleBinding

```bash
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: tiller-binding
  namespace: tiller-code
subjects:
- kind: ServiceAccount
  name: tiller
  namespace: tiller-code
roleRef:
  kind: Role
  name: tiller-manager
  apiGroup: rbac.authorization.k8s.io
```

5. Apply the changes to the Kubernetes Cluster

You will have to run these commands as an Admin of the Cluster

```bash
kubectl create -f anand-tiller-role.yaml
kubectl create -f anand-tiller-rolebinding.yaml
kubectl create -f code-tiller-role.yaml
kubectl create -f code-tiller-rolebinding.yaml

# Confirm that the role and rolebindings have been created in the respective namespace
k get role -n anand
k get rolebindings -n anand
k get role -n tiller-code
k get rolebindings -n tiller-code

```

5. Create Certificate Authority, Certs and Keys for the Tiller Server and Helm Client

```bash

# CA
openssl genrsa -out ./helm-tiller-ca.key.pem 4096
openssl req -key ./helm-tiller-ca.key.pem -new -x509 -days 1095 -sha256 -out helm-tiller-ca.cert.pem -extensions v3_ca

# Tiller Key, CSR and CA
openssl genrsa -out ./tiller-play.key.pem 4096
openssl req -key ./tiller-play.key.pem -new -sha256 -out ./tiller-play.csr.pem
openssl x509 -req -CA ./helm-tiller-ca.cert.pem -CAkey ./helm-tiller-ca.key.pem -CAcreateserial -in ./tiller-play.csr.pem -out tiller-play.cert.pem -days 365

# Helm Client Key, CSR and CA
openssl genrsa -out ./helm-anand-play.key.pem 4096
openssl req -key ./helm-anand-play.key.pem -new -sha256 -out helm-anand-play.csr.pem
openssl x509 -req -CA ./helm-tiller-ca.cert.pem -CAkey ./helm-tiller-ca.key.pem -CAcreateserial -in ./tiller-anand-play.csr.pem -out tiller-anand-play.cert.pem -days 365

```

6. Install Tiller

```bash
helm init \
  --dry-run --debug \
  --tiller-tls \
  --tiller-tls-cert ./tiller-play.cert.pem \
  --tiller-tls-key ./tiller-play.key.pem \
  --tiller-tls-verify \
  --tls-ca-cert helm-tiller-ca.cert.pem \
  --override 'spec.template.spec.containers[0].command'='{/tiller,--storage=secret}' \
  --tiller-namespace=tiller-code \
  --service-account=tiller
```

7. Configure Helm Client

```bash
helm version --client --short

# The failure is expected, since the client is trying to connect without TLS
helm version
Client: &version.Version{SemVer:"v2.10.0", GitCommit:"9ad53aac42165a5fadc6c87be0dea6b115f93090", GitTreeState:"clean"}
Error: cannot connect to Tiller
```

To fix this error, we will run the following:

```bash
cp helm-tiller-ca.cert.pem $(helm home)/ca.pem
cp helm-anand-play.cert.pem ~/.helm/cert.pem
cp helm-anand-play.key.pem ~/.helm/key.pem

# This command should have worked, but it kept giving this error
helm version --tls 
Client: &version.Version{SemVer:"v2.10.0", GitCommit:"9ad53aac42165a5fadc6c87be0dea6b115f93090", GitTreeState:"clean"}
Error: could not find tiller

# The error was that just like --tls, we also need to pass the --tiller-namespace option everytime we run the helm command
helm version --tls --tiller-namespace tiller-code version

```

8. Create an alias for the Helm client

```bash
alias h='helm'
TILLER_NAMESPACE='tiller-code'
```

### Helm Commands

```bash

# List releases
helm ls --tls

# Create Chart
helm create <chart-name>

# Look at the YAML output helm has "derived"
helm template .

# Install the Chart
helm install . --name=<release-name> --tls

# Perform a dry-run and debug before the installation
helm install . 

# Delete and Purge Releases
helm delete --purge <release-name> --tls


```
