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
