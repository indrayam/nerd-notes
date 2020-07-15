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

### Usage 3: SSH Config using ProxyJump or ProxyCommand

Source: [SSH to remote hosts though a proxy or bastion with ProxyJump](https://www.redhat.com/sysadmin/ssh-proxy-bastion-proxyjump)

```bash
### The Bastion Host
Host bastion1-rcdn
  HostName bastion1-rcdn-code.cisco.com
  User ubuntu
  Port 22
  IdentityFile ~/.ssh/id_rsa

## The Remote Host
Host nprd1-rcdn
  HostName 10.10.0.13
  User ubuntu
  Port 22
  ProxyJump bastion1-rcdn
OR
Host nprd1-rcdn
  HostName 10.10.0.13
  User ubuntu
  Port 22
  ProxyCommand ssh bastion1-rcdn -W %h:%p
```

Another way of doing this...

```bash
## CodeOn Deployment Server
Host codeon
  StrictHostKeyChecking no
  HostName codeon-deploy-alln.cisco.com
  User sdlcadm
  Port 22
  IdentityFile ~/.ssh/codeon_rsa

Host dba
  StrictHostKeyChecking no
  HostName drvprd-admin-server.cisco.com
  User oadrvprd
  Port 22
  IdentityFile ~/.ssh/codeon_rsa
  ProxyCommand ssh -W %h:%p codeon
  #ProxyJump codeon
```

### Usage 4: Samples

```bash
# Using ProxyCommand. Notice that whatever commands you pass to ProxyCommand is the command that is run locally first. Rest is run on the Proxy Host
ssh -o StrictHostKeyChecking=no -o ProxyCommand='ssh -W %h:%p -o IdentityFile=~/.ssh/codeon_rsa sdlcadm@codeon-deploy-alln.cisco.com' oadrvprd@drvprd-admin-server.cisco.com 'ls -al'

# Using ProxyJump
ssh -o StrictHostKeyChecking=no -o IdentityFile=~/.ssh/codeon_rsa -J sdlcadm@codeon-deploy-alln.cisco.com oadrvprd@drvprd-admin-server.cisco.com 'ls -al’
```