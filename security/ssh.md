# ssh 

### Usage 1: Run multiple commands

```bash
ssh -o StrictHostKeyChecking=no <user@host>
```

```bash
ssh -o StrictHostKeyChecking=no root@${CTRLPLANE_IP} << EOF
 tail -f /var/log/cloud-init-output.log
EOF
```

### Usage 2: Proxy from one host to next

```bash
Host aws
    Hostname 10.0.27.203
    Port 22
    User ubuntu
    IdentityFile ~/.ssh/id_rsa
    ProxyCommand ssh ubuntu@35.153.207.86 nc %h %p
```

```bash
ssh -o ProxyCommand="ssh user@ip-proxy-host nc %h %p" user@ip-destination-host
```
