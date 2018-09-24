# Spinnaker Blue/Green Demo

### HTTP Ping

```bash
while true; do curl -s https://helloclouddemo-bg.cisco.com/version | jq . ; done
```

### Get Pods (Blue)

```bash
watch -n 2 kubectl --context='cae-prd-rcdn-hcn' get pods -o wide -l app=hcnd-web-app-bg-blue
```

### Get Pods (Green)

```bash
watch -n 2 kubectl --context=cae-prd-rcdn-hcn get pods -o wide -l app=hcnd-web-app-bg-green
```

### Get Svc (BG)

```bash
watch -n 2 kubectl --context=cae-prd-rcdn-hcn get svc -l app=hcnd-web-app-bg -o wide
```
