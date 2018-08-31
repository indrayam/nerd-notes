# nginx

### TCP Proxy

```bash
stream {
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
