# nginx

## Update the default Nginx version on Ubuntu 18.04

[Source: How to Install Nginx Latest Version on Ubuntu 18.04, Ubuntu 19.04](https://www.linuxbabe.com/ubuntu/install-nginx-latest-version-ubuntu-18-04)

```bash
sudo wget https://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
sudo vim /etc/apt/sources.list.d/nginx.list

#Add the following lines to nginx.list:
deb [arch=amd64] http://nginx.org/packages/mainline/ubuntu/ focal nginx
deb-src http://nginx.org/packages/mainline/ubuntu/ focal nginx

sudo apt-get update
sudo apt-get remove nginx nginx-common nginx-full nginx-core #Remove existing Nginx install (if any)
sudo apt-get install nginx
sudo nginx -t # to check if the configuration is ok
sudo systemctl start nginx
# Enable auto start at boot time
sudo systemctl enable nginx
# Check status
sudo systemctl status nginx
```

Sample Reverse Proxy:

No SSL:

```
server {
	listen 80;
	listen [::]:80;

	access_log /var/log/nginx/reverse-access.log;
	error_log /var/log/nginx/reverse-error.log;

	location / {
    #proxy_set_header Host $host;
    #proxy_set_header X-Real-IP $remote_addr;
    proxy_pass https://alln-cloud-storage-1.cisco.com;
	}
}
```

With SSL:

```
server {
	listen 443 ssl;
	listen [::]:443 ssl;
  ssl_certificate /etc/ssl/codes3-cisco-com-stackedchain.pem;
  ssl_certificate_key /etc/ssl/codes3-cisco-com.key;
  server_name codes3-rtp1.cisco.com;

	access_log /var/log/nginx/reverse-access.log;
	error_log /var/log/nginx/reverse-error.log;

	location / {
    #proxy_set_header Host $host;
    #proxy_set_header X-Real-IP $remote_addr;
    proxy_pass https://rtp1-cloud-storage-1.cisco.com;
	}
}
```

Check the default configuration in `/etc/nginx/conf.d/default.conf`. Web root folder is `/usr/share/nginx/html`.

## Nginx as L4 TCP Proxy

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

## Nginx with Self-signed HTTPS (HTTP redirecting to HTTPS)

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

## Nginx with Certbot

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

## Nginx Proxy Pass with Rewrite

```bash
# Default server configuration

server {
  listen 80 default_server;
  listen [::]:80 default_server;
  server_name cdconsole-angular.cisco.com;

  proxy_set_header HOST $host;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

  location / {
      root   /web/cdconsole;
      index  index.html index.htm;
  }


  location /api {
    rewrite    /api/([^/]+) /$1 break;
    proxy_pass http://127.0.0.1:3000;
  }
}
```
