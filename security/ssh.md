# ssh 

### ssh add

- [Source](https://unix.stackexchange.com/questions/58969/how-to-list-keys-added-to-ssh-agent-with-ssh-add)
- [Source](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

If you add new SSH keys, you will have add the SSH key to the ssh-agent by running the following commands:

```bash
ssh-add ~/.ssh/id_rsa
# To list all the keys added to the agent, run the following command
ssh-add -l 
# OR
ssh-add -L
```

### ssh-keygen 

```bash
# To generate fingerprint from RSA public key
ssh-keygen -lf /path/to/key.pub

```

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

Host codeon1
  StrictHostKeyChecking no
  HostName sdlc-dply-prd-01.cisco.com
  User sdlcadm
  Port 22
  IdentityFile ~/.ssh/codeon_rsa

Host codeon2
  StrictHostKeyChecking no
  HostName sdlc-dply-prd-02.cisco.com
  User sdlcadm
  Port 22
  IdentityFile ~/.ssh/codeon_rsa

Host codeon3
  StrictHostKeyChecking no
  HostName sdlc-dply-prd-03.cisco.com
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
