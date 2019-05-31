# istio

## Installing Istio

```bash
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.1.7 sh -
export PATH="$PATH:/Users/anasharm/workspace/istio-1.1.7/bin"
cd istio-1.1.7
ls
istioctl version --short
helm version --client --short
export NAMESPACE=istio-system
kubectl create namespace $NAMESPACE
kn $NAMESPACE
helm template install/kubernetes/helm/istio-init --name istio-init --namespace $NAMESPACE | kubectl apply -f -
kubectl get crds | grep 'istio.io\|certmanager.k8s.io' | wc -l
# Number should be 53
```

### Default Istio installation

```
helm template install/kubernetes/helm/istio --name istio --namespace $NAMESPACE | kubectl apply -f -
k get all -n $NAMESPACE
```

### Customized Istio installation

1. If you are enabling `kiali`, you need to create the secret that contains the username and passphrase for `kiali` dashboard:

- Encode username, you can change the username to the name as you want:

```bash
echo -n 'admin' | base64
$ YWRtaW4=
```
- Encode passphrase, you can change the passphrase to the passphrase as you want:

```
$ echo -n 'admin' | base64
YWRtaW4=
```

- Create secret for Kiali:

```
$ cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kiali
  namespace: $NAMESPACE
  labels:
    app: kiali
type: Opaque
data:
  username: YWRtaW4=
  passphrase: dWR0cjBja3Mh
EOF
```

- Test:

```
k view-secret kiali username
k view-secret kiali passphrase
```

2. If you are using security mode for Grafana, create the secret first as follows:

- Encode username, you can change the username to the name as you want:

```
$ echo -n 'admin' | base64
YWRtaW4=
```

- Encode passphrase, you can change the passphrase to the passphrase as you want:

```
$ echo -n 'admin' | base64
YWRtaW4=
```

- Create secret for Grafana:

```
$ cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: grafana
  namespace: $NAMESPACE
  labels:
    app: grafana
type: Opaque
data:
  username: YWRtaW4=
  passphrase: dWR0cjBja3Mh
EOF
```

- Test:

```
k view-secret grafana username
k view-secret grafana passphrase
```

3. Invoke Helm template with the customizations you like

```
helm template install/kubernetes/helm/istio --name istio \
--set global.mtls.enabled=false \
--set tracing.enabled=true \
--set kiali.enabled=true \
--set grafana.enabled=true \
--set gateways.istio-ingressgateway.type=NodePort --namespace $NAMESPACE > istio.yaml
k apply -f istio.yaml
```

## Running Bookinfo sample 

```
kn default
kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)
kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
export GATEWAY_URL=64.102.179.211
curl -s http://${GATEWAY_URL}/productpage | grep -o "<title>.*</title>"
kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
k get virtualservices
k get gateway
k get destinationrules
k get pods
k get svc
```

### Traffic Management Steps

Bookinfo sample application:

```
kn default
kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-50-v3.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-v3.yaml
```

TCP Echo sample application:

```
kn default
kubectl apply -f <(istioctl kube-inject -f samples/tcp-echo/tcp-echo-services.yaml)
export INGRESS_HOST=64.102.179.211
export INGRESS_PORT=31400
for i in {1..10}; do \
    docker run -e INGRESS_HOST=$INGRESS_HOST -e INGRESS_PORT=$INGRESS_PORT -it --rm busybox sh -c "(date; sleep 1) | nc $INGRESS_HOST $INGRESS_PORT"; \
done
docker run -e INGRESS_HOST=$INGRESS_HOST -e INGRESS_PORT=$INGRESS_PORT -it --rm busybox sh -c "(date; sleep 1) | nc $INGRESS_HOST $INGRESS_PORT"
sh -c "(date; sleep 1) | nc -c $INGRESS_HOST $INGRESS_PORT"
```

## Uninstall

```bash
helm template install/kubernetes/helm/istio --name istio --namespace $NAMESPACE | kubectl delete -f -
kubectl delete namespace $NAMESPACE
```

