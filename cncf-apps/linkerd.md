# linkerd

## Install Linkerd

```bash
curl -sL https://run.linkerd.io/install | sh
# Add this to your zsh profile:
# export PATH=$PATH:$HOME/.linkerd2/bin 
# source ~/.zshrc
linkerd version
linkerd check --pre
# Run this to create a local copy of the Kubernetes resources that will be created by Linkerd
# linkerd install > linkerd-control-plane.yaml
linkerd install | kubectl apply -f -
linkerd check
kubectl -n linkerd get deploy
kubectl -n linkerd get all
kubectl -n linkerd get svc
linkerd dashboard &
```

## Expose Linkerd Dashboard using TCP Proxy

Create a `linkerd-ingress.yaml` file

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: linkerd
spec:
  rules:
  - host: linkerd-code.cisco.com
    http:
      paths:
      - backend:
          serviceName: linkerd-web
          servicePort: 8084
```

Run: `k apply -f linkerd-ingress.yaml`

To test, run:

`curl -L -H "Host: linkerd-code.cisco.com" http://${INGRESS_HOST}/`
