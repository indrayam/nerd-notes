# ufw firewall configuration tool (ubuntu)

### Status

```bash
sudo ufw status
```

### Enabled

```bash
sudo ufw enable
```

### List all applications

```bash
sudo ufw all list
```

### Allow/Deny Application and/or Port

```bash
sudo ufw allow 'Nginx Full'
sudo ufw allow 'OpenSSH'
sudo ufw allow 53/tcp # port/protocol
sudo ufw deny 53/tcp
```

### Allow/Deny by Service
You can allow or deny by service name since ufw reads from /etc/services

```bash
sudo ufw allow ssh
sudo ufw deny ssh
```

### Delete Rules

```bash
sudo ufw delete deny 80/tcp
```


### Advanced Syntax

```bash
sudo ufw allow from 192.168.1.0 # IP Address
sudo ufw allow from 192.168.1.0/24 # Subnet
sudo ufw allow from 192.168.0.4 to any port 22 # allow IP address 192.168.0.4 access to port 22 for all protocols
sudo ufw allow from 192.168.0.4 to any port 22 proto tcp # allow IP address 192.168.0.4 access to port 22 using TCP
```





