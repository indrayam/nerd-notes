# heptio contour

## References

1. [Medium: How-To: Deploy web applications on Kubernetes with Heptio Contour and Let’s Encrypt](https://blog.heptio.com/how-to-deploy-web-applications-on-kubernetes-with-heptio-contour-and-lets-encrypt-d58efbad9f56)
2. [Contour: Documentation](https://projectcontour.io/docs/master/)

## Install Contour

```bash
curl -O -L https://j.hept.io/contour-deployment-rbac
mv contour-deployment-rbac contour-deployment-rbac.yaml
# Update Service Type from LoadBalancer to NodePort (last line)
k apply -f contour-deployment-rbac.yaml
kubectl -n heptio-contour get po
kubectl get -n heptio-contour service contour -o wide
# Use the port "30677" from the output "80:30677/TCP,443:32526/TCP" if you are configuring HTTP in your TCP Proxy
# Use the port "32526" from the output "80:30677/TCP,443:32526/TCP" if you are configuring HTTPS in your TCP Proxy
```

## Test Contour setup using Kuard

```bash
curl -L -O https://j.hept.io/contour-kuard-example
mv contour-kuard-example contour-kuard-example.yaml
kn default
k apply -f contour-kuard-example.yaml
kubectl get po -l app=kuard -o wide
export INGRESS_HOST=64.102.179.211
curl -s http://${INGRESS_HOST}/ | grep -i "KUAR Demo"
# Output:   <title>KUAR Demo</title>
```


