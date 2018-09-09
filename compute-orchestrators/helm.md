# Helm

### Install Helm Client

```bash
brew install kubernetes-helm
```

To configure Helm client, but not install Tiller, do the following:

```bash
helm init --client-only
```

### Secure Installation of Helm

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
alias h='helm version --tls --tiller-namespace tiller-code version'
```





