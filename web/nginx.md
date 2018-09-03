# nginx

### Update the default Nginx version on Ubuntu 16.04

```bash
sudo wget https://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
sudo vim /etc/apt/sources.list.d/nginx.list 
  #Add the following lines to nginx.list:
  deb https://nginx.org/packages/mainline/ubuntu/ xenial nginx
  deb-src https://nginx.org/packages/mainline/ubuntu/ xenial nginx
sudo apt-get remove nginx #Remove existing Nginx install (if any)
sudo apt-get update
sudo apt-get install nginx
sudo vim /etc/nginx/tcppassthrough.conf (Update the Upstream Port numbers for 80 and/or 443) # See above
sudo nginx -t # to check if the configuration is ok
```

### Nginx as L4 TCP Proxy

Update /etc/nginx/nginx.conf with these changes to the http block...

```bash
    #include /etc/nginx/conf.d/*.conf;
    #include /etc/nginx/sites-enabled/*;
}

include /etc/nginx/tcppassthrough.conf;
```

```bash
stream {
    log_format combined '$remote_addr - - [$time_local] $protocol $status $bytes_sent $bytes_received $session_time "$upstream_addr"';
    access_log /var/log/nginx/stream-access.log combined;
    upstream httpproxy {
      server 64.102.179.238:8080 max_fails=3 fail_timeout=10s;
    }
 
    server {
      listen 80;
      proxy_pass httpproxy;
      proxy_next_upstream on;
    }
}
```

### Nginx with Self-signed HTTPS (HTTP redirecting to HTTPS)

Create a certificate and key for the domain (see openssl for details)

1. Edit `/etc/nginx/sites-available/default` with the following

```bash
# Default server configuration

server {
  listen 80 default_server;
  listen [::]:80 default_server;
  server_name jenkins-code.cisco.com;
  return 301 https://$server_name$request_uri;
}
```
2. Create a new file (say, `jenkins-code`) for the new domain in the same folder

```bash
# Virtual Host configuration for example.com
#
server {
  listen 443 ssl;
  ssl_certificate /etc/nginx/ssl/jenkins-code.cisco.com.crt;
  ssl_certificate_key /etc/nginx/ssl/jenkins-code.cisco.com.key;

  server_name jenkins-code.cisco.com;

  proxy_set_header HOST $host;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

  location / {
    proxy_pass http://127.0.0.1:8080;
  }
}
```

3. Add a soft link in `/etc/nginx/sites-available/` for the new file `jenkins-code` above
4. Make sure `/etc/nginx/nginx.conf` has these lines in the http block:

```bash
#include /etc/nginx/conf.d/*.conf;
include /etc/nginx/sites-enabled/*;
```
4. sudo nginx -t
5. sudo systemctl stop nginx
6. sudo systemctl start nginx

### Nginx with Certbot

```bash

## Install Nginx and Certbot
USER_ID="ubuntu"
export HOSTNAME=$(hostname)
WEBROOT='/var/www/html'
apt-get install -y nginx certbot
mkdir -p /var/www/letsencrypt/.well-known/acme-challenge
chown ${USER_ID}.${USER_ID} $WEBROOT
cat > $WEBROOT/index.html << EOF
<html>
  <head>
    <title>VM Demo from ${HOSTNAME}</title>
  </head>
  <body>
    <h3>VM Demo from ${HOSTNAME}</h3>
  </body>
</html>
EOF
chown ${USER_ID}.${USER_ID} $WEBROOT/index.html

```




