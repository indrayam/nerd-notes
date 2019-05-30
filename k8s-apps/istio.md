# istio

## Installing Istio

```
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.1.7 sh -
export PATH="$PATH:/Users/anasharm/workspace/istio-1.1.7/bin"
cd istio-1.1.7
ls
helm version
kubectl create namespace istio-system
kn istio-system
helm template install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -
kubectl get crds | grep 'istio.io\|certmanager.k8s.io' | wc -l
k get crds
helm template install/kubernetes/helm/istio --name istio --namespace istio-system | kubectl apply -f -
k get all -n istio-system
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

```
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-50-v3.yaml
kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-v3.yaml
```

