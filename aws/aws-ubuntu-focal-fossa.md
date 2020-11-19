# AWS Ubuntu 20.04 (Focal Fossa)

## User Data

```bash
#!/bin/bash
apt-get update -y
#apt-get upgrade -y
cd /home/ubuntu
curl -L -o run.sh https://bit.ly/39ago
chown ubuntu.ubuntu run.sh
chmod +x run.sh
apt-get install nginx -y
chown -R ubuntu.ubuntu /var/www/html/
ln -s /var/www/html/ html
chown -h ubuntu.ubuntu html
```