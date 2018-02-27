# istioctl

### help

```bash
istioctl help
```

### Interact with kube-inject sub-command

```bash
istioctl kube-inject -f app.yaml
kubectl -f create <(istioctl kube-inject -f app.yaml)
```

### Interact with routerules sub-command

```bash
istioctl get routerules
istioctl get routerule ratings-default -o yaml
```
