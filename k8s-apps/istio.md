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

```bash
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

```bash
$ echo -n 'admin' | base64
YWRtaW4=
```

- Create secret for Kiali:

```bash
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
  passphrase: YWRtaW4=
EOF
```

- Test:

```bash
k view-secret kiali username
k view-secret kiali passphrase
```

2. If you are using security mode for Grafana, create the secret first as follows:

- Encode username, you can change the username to the name as you want:

```bash
$ echo -n 'admin' | base64
YWRtaW4=
```

- Encode passphrase, you can change the passphrase to the passphrase as you want:

```bash
$ echo -n 'admin' | base64
YWRtaW4=
```

- Create secret for Grafana:

```bash
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
  passphrase: YWRtaW4=
EOF
```

- Test:

```bash
k view-secret grafana username
k view-secret grafana passphrase
```

3. Invoke Helm template with the customizations you like

```bash
helm template install/kubernetes/helm/istio --name istio \
--set global.mtls.enabled=false \
--set tracing.enabled=true \
--set kiali.enabled=true \
--set grafana.enabled=true \
--set prometheus.enabled=true \
--set "kiali.dashboard.jaegerURL=http://jaeger-query:16686" \
--set "kiali.dashboard.grafanaURL=http://grafana:3000" \
--set gateways.istio-ingressgateway.type=NodePort --namespace $NAMESPACE > istio.yaml
k apply -f istio.yaml
```

## Running Bookinfo sample 

```bash
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

### Bookinfo sample application

```bash
kn default
export INGRESS_HOST=64.102.179.211
kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)
kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
# This should work and spit out "<title>Simple Bookstore App</title>"
curl -I http://${INGRESS_HOST}/productpage
# This should NOT work and give error message
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
k get gateway
k get virtualservice
curl -I http://${INGRESS_HOST}/productpage
# This should work and spit out something like below...
# HTTP/1.1 200 OK
# content-type: text/html; charset=utf-8
# content-length: 5723
# server: istio-envoy
# date: Fri, 31 May 2019 15:00:41 GMT
# x-envoy-upstream-service-time: 683
curl -s http://${INGRESS_HOST}/productpage | grep -o "<title>.*</title>"
# This might be a simpler test. And yes, it should work too!
k get destinationrules
# This should be empty
kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml # apply desitnation rules
k get destinationrules
```

Playing with Traffic Management:

```bash
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-50-v3.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-v3.yaml
# Remove it all
kubectl delete -f samples/bookinfo/networking/virtual-service-all-v1.yaml
```

### TCP Echo sample application

```bash
kn default
kubectl apply -f <(istioctl kube-inject -f samples/tcp-echo/tcp-echo-services.yaml)
# Define Gateway, Destination Rule
# Virtual Service which routes things to v1
kubectl apply -f samples/tcp-echo/tcp-echo-all-v1.yaml
export INGRESS_HOST=64.102.179.211
export INGRESS_PORT=31400
for i in {1..10}; do \
    docker run -e INGRESS_HOST=$INGRESS_HOST -e INGRESS_PORT=$INGRESS_PORT -it --rm busybox sh -c "(date; sleep 1) | nc $INGRESS_HOST $INGRESS_PORT"; \
done
# Virtual Service which routes things 20% of traffic to v2
kubectl apply -f samples/tcp-echo/tcp-echo-20-v2.yaml
for i in {1..10}; do \
    docker run -e INGRESS_HOST=$INGRESS_HOST -e INGRESS_PORT=$INGRESS_PORT -it --rm busybox sh -c "(date; sleep 1) | nc $INGRESS_HOST $INGRESS_PORT"; \
done
# docker run -e INGRESS_HOST=$INGRESS_HOST -e INGRESS_PORT=$INGRESS_PORT -it --rm busybox sh -c "(date; sleep 1) | nc $INGRESS_HOST $INGRESS_PORT"
# sh -c "(date; sleep 1) | nc -c $INGRESS_HOST $INGRESS_PORT"
```

### Httpbin sample application

```bash
kn default
kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml)
# Define Gateway and Virtual Service
kubectl apply -f samples/httpbin/httpbin-gateway.yaml
export INGRESS_HOST=64.102.179.211
curl --silent httpbin-code.cisco.com/html
curl --silent --head httpbin-code.cisco.com/status/500
curl --silent httpbin-code.cisco.com/delay/5
```

## Access Kiali

```bash
k port-forward -n istio-system svc/kiali 20001
kubectl port-forward $(kubectl get pod -n istio-system -l app=kiali -o jsonpath='{.items[0].metadata.name}') -n $NAMESPACE 20001:20001 &
watch -n 1 curl -o /dev/null -s -w %{http_code} $INGRESS_HOST/productpage
# OR, kubectl -n istio-system port-forward kiali-5c584d45f6-2kz2x 20001:20001
# Open http://localhost:20001/kiali/console
# Login with admin and the password you set
```

## Access Grafana

```bash
# Make sure these services are working
kubectl -n $NAMESPACE get svc prometheus
kubectl -n $NAMESPACE get svc grafana
k port-forward -n istio-system svc/grafana 3000
kubectl -n $NAMESPACE port-forward $(kubectl -n $NAMESPACE get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
# Open http://localhost:3000/dashboard/db/istio-mesh-dashboard
```

## Access Jaeger

```bash
k port-forward -n istio-system svc/jaeger-query 16686
# Open http://localhost:16686
```

## Remotely Accessing Telemetry Addons

Kiali:

```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: kiali-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 15029
      name: http-kiali
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: kiali-vs
  namespace: istio-system
spec:
  hosts:
  - "*"
  gateways:
  - kiali-gateway
  http:
  - match:
    - port: 15029
    route:
    - destination:
        host: kiali
        port:
          number: 20001
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: kiali
  namespace: istio-system
spec:
  host: kiali
  trafficPolicy:
    tls:
      mode: DISABLE
---
EOF
```

Grafana:

```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: grafana-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 15031
      name: http-grafana
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: grafana-vs
  namespace: istio-system
spec:
  hosts:
  - "*"
  gateways:
  - grafana-gateway
  http:
  - match:
    - port: 15031
    route:
    - destination:
        host: grafana
        port:
          number: 3000
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: grafana
  namespace: istio-system
spec:
  host: grafana
  trafficPolicy:
    tls:
      mode: DISABLE
---
EOF
```

Prometheus

```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: prometheus-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 15030
      name: http-prom
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: prometheus-vs
  namespace: istio-system
spec:
  hosts:
  - "*"
  gateways:
  - prometheus-gateway
  http:
  - match:
    - port: 15030
    route:
    - destination:
        host: prometheus
        port:
          number: 9090
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: prometheus
  namespace: istio-system
spec:
  host: prometheus
  trafficPolicy:
    tls:
      mode: DISABLE
---
EOF
```

Tracing

```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: tracing-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 15032
      name: http-tracing
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: tracing-vs
  namespace: istio-system
spec:
  hosts:
  - "*"
  gateways:
  - tracing-gateway
  http:
  - match:
    - port: 15032
    route:
    - destination:
        host: tracing
        port:
          number: 80
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: tracing
  namespace: istio-system
spec:
  host: tracing
  trafficPolicy:
    tls:
      mode: DISABLE
---
EOF
```

## Uninstall

```bash
export NAMESPACE="istio-system"
# Bookinfo
samples/bookinfo/platform/kube/cleanup.sh
# TCP Echo
kubectl delete -f samples/tcp-echo/tcp-echo-all-v1.yaml
kubectl delete -f samples/tcp-echo/tcp-echo-services.yaml
# Httpbin
kubectl delete -f samples/httpbin/httpbin.yaml
kubectl delete -f samples/httpbin/httpbin-gateway.yaml
# Istio
kubectl delete -f install/kubernetes/helm/istio-init/files
helm template install/kubernetes/helm/istio --name istio --namespace $NAMESPACE | kubectl delete -f -
# Istio Namespace
kubectl delete namespace $NAMESPACE
```
